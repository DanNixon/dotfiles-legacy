#!/bin/sh

saucenao.py $1 | jq -r "(.header.long_remaining, .header.short_remaining, .results[].data.ext_urls)"
