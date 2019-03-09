#!/usr/bin/env python3

# Requires https://github.com/mobolic/facebook-sdk
# Grab a token from the API explorer: https://developers.facebook.com/tools/explorer/

import sys
import webbrowser

import click
import facebook


def query_yes_no(question, default="yes"):
    """Ask a yes/no question via raw_input() and return their answer.

    "question" is a string that is presented to the user.
    "default" is the presumed answer if the user just hits <Enter>.
        It must be "yes" (the default), "no" or None (meaning
        an answer is required of the user).

    The "answer" return value is True for "yes" or False for "no".
    """
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            sys.stdout.write("Please respond with 'yes' or 'no' "
                             "(or 'y' or 'n').\n")


def get_display_field(l):
    for n in ['name', 'message', 'id']:
        if n in l:
            return l[n]

    return str(l)


def process_batch(batch):
    for l in batch:
        click.echo('> {}'.format(get_display_field(l)))

    if query_yes_no('Open in browser?', 'no'):
        for l in batch:
            webbrowser.open('https://www.facebook.com/{}'.format(l['id']))


@click.command()
@click.option('--token', help='User access token')
@click.option('--connection', help='Connection type (likes, friends, posts, etc.)')
def main(token, connection):
    graph = facebook.GraphAPI(access_token=token, version="3.0")

    batch = []
    for l in graph.get_all_connections(id='me', connection_name=connection):
        batch.append(l)
        if len(batch) >= 8:
            process_batch(batch)
            batch = []


if __name__ == '__main__':
    main()
