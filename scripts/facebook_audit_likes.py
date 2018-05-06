#!/usr/bin/env python3

# Requires https://github.com/mobolic/facebook-sdk

import click
import facebook

import webbrowser


@click.command()
@click.option('--token', help='User access token')
def main(token):
    graph = facebook.GraphAPI(access_token=token, version="3.0")

    count = 0
    for l in graph.get_all_connections(id='me', connection_name='likes'):
        webbrowser.open('https://www.facebook.com/{}'.format(l['id']))
        count += 1
        if count >= 7:
            input("Press Enter to open next batch...")
            count = 0


if __name__ == '__main__':
    main()
