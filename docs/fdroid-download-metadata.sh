#!/bin/bash

data_dir="$1"
mkdir -p "$data_dir"

function find_fdroid_packages {
  sed -n -r "s/^.*packages\/(.*)\/.*$/\1/p"
}

function download_package_metadata {
  package="$1"
  url="https://f-droid.org/packages/$package"
  curl --location --silent "$url" | fdroid.py | jq '.' > "$data_dir/$package.json"
}

for package in `find_fdroid_packages`; do
  echo "$package"
  download_package_metadata "$package"
done
