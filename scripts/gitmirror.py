#!/usr/bin/env python3

import click


def get_folder_path_from_url(url):
    import os
    from urllib.parse import urlparse
    url = url.strip()
    parse_object = urlparse(url)
    target_dir = parse_object.netloc + os.path.splitext(parse_object.path)[0]
    return target_dir


def get_stdin():
    from sys import stdin
    for line in stdin:
        yield tuple([i.strip() for i in line.split()])


def do_mirror_clone(url, target_dir, verbose=False):
    import os
    import subprocess

    if os.path.exists(target_dir):
        return 'directory_already_exists'

    args = {}
    if not verbose:
        args['stdout'] = subprocess.DEVNULL
        args['stderr'] = subprocess.DEVNULL

    os.makedirs(os.path.dirname(target_dir), exist_ok=True)
    result = subprocess.run(['git', 'clone', '--mirror', url, target_dir], **args)
    return result.returncode


def is_bare_git_repo(path):
    import subprocess
    try:
        res = subprocess.check_output(['git', 'rev-parse', '--is-bare-repository'], cwd=path, stderr=subprocess.DEVNULL)
        return res.strip() == b'true'
    except subprocess.CalledProcessError:
        return False


def find_git_repos():
    import os
    for root, dirs, _ in os.walk(os.path.curdir):
        if is_bare_git_repo(root):
            dirs.clear()
            yield root


def do_git_fetch(repo_path, verbose=False):
    import subprocess

    args = {
        'cwd': repo_path
    }
    if not verbose:
        args['stdout'] = subprocess.DEVNULL
        args['stderr'] = subprocess.DEVNULL

    result = subprocess.run(['git', 'fetch', '-p'], **args)
    return result.returncode


@click.group()
def main():
    import colorama
    colorama.init()


@main.command()
@click.option('-w', '--workers', default=4)
@click.option('-v', '--verbose', is_flag=True)
def init(workers, verbose):
    import concurrent.futures
    from colorama import Fore, Style

    with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as executor:
        futures = {}

        for l in get_stdin():
            if len(l) == 1:
                args = (l[0], get_folder_path_from_url(l[0]))
            elif len(l) == 2:
                args = l
            else:
                continue

            futures[executor.submit(do_mirror_clone, *args, verbose=verbose)] = args

        for future in concurrent.futures.as_completed(futures):
            args = futures[future]
            result_col = Fore.GREEN if future.result() == 0 else Fore.RED
            print(
                result_col + str(future.result()),
                Fore.YELLOW + args[0],
                Style.RESET_ALL + '->',
                Fore.BLUE + args[1],
                Style.RESET_ALL
            )


@main.command()
@click.option('-w', '--workers', default=4)
@click.option('-v', '--verbose', is_flag=True)
def update(workers, verbose):
    import concurrent.futures
    from colorama import Fore, Style

    with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as executor:
        futures = {}

        for repo_path in find_git_repos():
            futures[executor.submit(do_git_fetch, repo_path, verbose)] = repo_path

        for future in concurrent.futures.as_completed(futures):
            args = futures[future]
            result_col = Fore.GREEN if future.result() == 0 else Fore.RED
            print(
                result_col + str(future.result()),
                Fore.BLUE + args,
                Style.RESET_ALL
            )


if __name__ == '__main__':
    main()
