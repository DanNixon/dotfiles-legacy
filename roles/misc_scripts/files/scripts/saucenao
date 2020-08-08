#!/usr/bin/env python3

import click
import requests
import sys


@click.command()
@click.option('--username', type=str)
@click.option('--api-key', type=str)
@click.argument('image', type=click.File('rb'))
def main(username, api_key, image):
    """
    Super basic script to query saucenao with a local image.
    """
    params = {
        'output_type': 2
    }

    if username and api_key:
        params.update({
            'username': username,
            'api_key': api_key,
        })

    req = requests.post(
            'https://saucenao.com/search.php',
            files={'file': image},
            params=params,
        )

    print(req.text)

    if req.status_code != requests.codes.ok:
        sys.exit(1)


if __name__=='__main__':
    main()
