#!/usr/bin/env python3

import colorama
import click
import itertools
import json
import requests

from colorama import Fore, Style


class GitHubClient(object):
    """
    Class for handling GraphQL queries for GitHub's APIv4.
    """

    def __init__(self, access_token):
        # GitHub APIv4 endpoint
        self.endpoint = "https://api.github.com/graphql"

        # Create GraphQL Authorization header
        self.auth = {"Authorization": "Bearer {}".format(access_token)}

        # Initialise empty GraphQL variables dictionary
        self.variables = {}

        # Number of results to return per page
        self.page_size = 25

    def send_query(self, query):
        """
        Sends Query as JSON object, reply formatted as nested python dictionary
        """
        # Read query and variables into JSON formatted string
        message = json.dumps({"query": query, "variables": self.variables})

        # Convert Python None to JSON null
        payload = message.replace("None", "null")

        # Post Query, recieve reply
        reply = requests.post(self.endpoint, payload, headers=self.auth)

        # Return reply as a nested Python dictionary
        return reply.json()

    def fetch_pull_requests(self):
        query = \
            """
            query($page_size: Int!, $cursor: String) {
                viewer {
                    pullRequests(last: $page_size, after: $cursor, states:[OPEN]){
                        pageInfo {
                            hasNextPage
                            endCursor
                        }
                        nodes {
                            number
                            title
                            baseRefName
                            headRefName
                            mergeable
                            url
                            repository {
                                owner {
                                    login
                                }
                                name
                            }
                            headRepository {
                                owner {
                                    login
                                }
                                name
                            }
                            commits (last:1) {
                                nodes {
                                    commit {
                                        status {
                                            state
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            """

        # Create optional cursor variable (used for pagination)
        self.variables['cursor'] = None
        # Set number of results per page (max: 100)
        self.variables['page_size'] = self.page_size

        pull_requests = []

        # Fetch data from GitHub, iterate through Pull Requests if there are
        # more pages of data
        while True:
            data = self.send_query(query)
            pull_requests += data['data']['viewer']['pullRequests']['nodes']

            # If more pull requests, update cursor to point to new page
            if data['data']['viewer']['pullRequests']['pageInfo']['hasNextPage']:
                self.variables['cursor'] = \
                        data['data']['viewer']['pullRequests']['pageInfo']['endCursor']
            else:
                # No more data, stop pagination
                break

        # Remove non-default variables
        del self.variables['page_size'], self.variables['cursor']

        return pull_requests


@click.command()
@click.option('--token', type=str, required=True,
              help='GitHub Personal Access token.')
def main(token):
    """
    Simple tool to check the status of your pull requests on GitHub.
    """
    colorama.init()

    gh_client = GitHubClient(token)
    all_prs = gh_client.fetch_pull_requests()

    result_colours = {
            True: Fore.GREEN,
            False: Fore.RED,
            'ERROR':  Fore.RED,
            'EXPECTED': Fore.YELLOW,
            'FAILURE': Fore.RED,
            'PENDING': Fore.YELLOW,
            'SUCCESS': Fore.GREEN
        }

    result_marks = {
            True: '✔',
            False: '✘',
            'ERROR':  '✘',
            'EXPECTED': '●',
            'FAILURE': '✘',
            'PENDING': '●',
            'SUCCESS': '✔'
        }

    def get_check_str(result):
        return '{c}{mark}{rst}'.format(
                    c=result_colours[result],
                    mark=result_marks[result],
                    rst=Style.RESET_ALL)

    for org, org_prs in itertools.groupby(all_prs, lambda p: p['repository']['owner']['login']):
        click.echo('- {}{}{}'.format(Fore.CYAN, org, Style.RESET_ALL))
        for repo, repo_prs in itertools.groupby(org_prs, lambda p: p['repository']['name']):
            click.echo('  - {}{}{}'.format(Fore.BLUE, repo, Style.RESET_ALL))
            for pr in repo_prs:
                mergeable = pr['mergeable'] == 'MERGEABLE'
                last_commit = pr['commits']['nodes'][0]['commit']
                ci_state = last_commit['status']['state'] if last_commit['status'] else None

                checks = get_check_str(mergeable)

                if ci_state is not None:
                    checks += ' ' + get_check_str(ci_state)

                click.echo('    - {y}#{pr[number]}{rst}: {pr[title]} {checks}'.format(
                    pr=pr, checks=checks, y=Fore.YELLOW, rst=Style.RESET_ALL))

                if mergeable is False or (ci_state is not None and not ci_state == 'SUCCESS'):
                    click.echo('      {dim}{pr[url]}{rst}'.format(
                        pr=pr, dim=Style.DIM, rst=Style.RESET_ALL))


if __name__ == '__main__':
    main()