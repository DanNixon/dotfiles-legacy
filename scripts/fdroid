#!/usr/bin/env python3

# Hacky script to export verson details from an F-Droid page.

import bs4
import re
import sys


date_regex = re.compile('\d{4}\-\d{2}\-\d{2}')


def parse_permissions(pv):
    permission_ul = pv.find('ul', class_='package-version-permissions-list')
    return [p.text.strip() for p in permission_ul.children if p.name == 'li']


def parse_version(pv):
    version_header = pv.find('div', class_='package-version-header')
    download_text = pv.find('p', class_='package-version-download')

    return {
        'version': version_header.find('a').attrs['name'],
        'number': int(version_header.find_all('a')[1].attrs['name']),
        'uploaded': date_regex.search(version_header.text).group(0),
        'urls': {
            'source_tarball': pv.find('p', class_='package-version-source').find('a').attrs['href'],
            'package': download_text.find('a').attrs['href'],
            'package_signature': download_text.find_all('a')[1].attrs['href'],
        },
        'android': {
            'version_requirement': pv.find('p', class_='package-version-requirement').text.strip(),
            'permissions': parse_permissions(pv),
        },
    }


body = sys.stdin.read()
soup = bs4.BeautifulSoup(body, features='html.parser')

package_versions_list = soup.find('ul', class_='package-versions-list')
package_versions = package_versions_list.find_all('li', class_='package-version')
versions = [parse_version(pv) for pv in package_versions]

import json
print(json.dumps(versions))
