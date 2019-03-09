#!/usr/bin/env python3

# Extracts channel names and URLs from YouTube subscriptions exported in JSON
# format.
# Usage: youtube_export_extract_channels.py [subscriptions.json]

import sys
import json


def parse_single(data):
    return (
        data['snippet']['title'],
        'https://www.youtube.com/channel/' + data['snippet']['resourceId']['channelId']
    )


def parse_all_data(data):
    for d in data:
        yield parse_single(d)


def main():
    with open(sys.argv[1]) as f:
        data = json.load(f)
        for name, url in parse_all_data(data):
            print(name + '\t' + url)


if __name__ == '__main__':
    main()
