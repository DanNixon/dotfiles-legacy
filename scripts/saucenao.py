#!/usr/bin/env python3

# Super basic script to query saucenao with a local image.
# Usage: saucenao.py [image filename]

import sys
import requests

image_filename = sys.argv[1]

with open(image_filename, 'rb') as img_file:
    r = requests.post(
            'https://saucenao.com/search.php',
            files={'file': img_file},
            params={'output_type': 2},
        )

    print(r.text)
