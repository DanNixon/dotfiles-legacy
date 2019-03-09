#!/usr/bin/env python3

# Used to extract video titles and URLs from a YouTube playlist page.
# For some reason some videos were missing from the Google Takeout export,
# hence the need for this script.
# A very hacky implementation that will likely break quickly.

# Usage: ./youtube_playlist_page_extract_videos.py [playlist page].html

import sys
from bs4 import BeautifulSoup
from urllib.parse import urlparse


def clean_url(u):
    url = urlparse(u)
    vid_query = [p for p in url.query.split("&") if p.startswith('v=')][0]
    return url.scheme + "://" + url.netloc + url.path + "?" + vid_query


with open(sys.argv[1]) as f:
    soup = BeautifulSoup(f)

video_elements = soup.find_all("a", class_="yt-simple-endpoint style-scope ytd-playlist-video-renderer")

for video in video_elements:
    title_span = video.find_all("span", class_="style-scope ytd-playlist-video-renderer")[0]

    url = video.attrs.get('href')
    title = title_span.attrs.get('title')

    if url is not None:
        print('"{}" "{}"'.format(title, clean_url(url)))
