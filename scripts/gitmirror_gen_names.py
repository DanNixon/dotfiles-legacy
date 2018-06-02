#!/usr/bin/env python3

import os
from sys import stdin
from urllib.parse import urlparse

for line in stdin:
    url = line.strip()
    parse_object = urlparse(url)
    target_dir = parse_object.netloc + os.path.splitext(parse_object.path)[0]
    print(url, target_dir)
