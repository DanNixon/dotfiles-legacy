#!/bin/bash

# Get URL metadata
urls=`jq '.[0].urls'`

# Get binary package and signature URLs
package_url=`echo "$urls" | jq -r '.package'`
signature_url=`echo "$urls" | jq -r '.package_signature'`

package_filename=`basename "$package_url"`

# Download binary and signature if the binary does not exist
if [ ! -f "$package_url" ]; then
  wget "$package_url"
  wget "$signature_url"
fi

signature_filename=`basename "$signature_url"`

# Get GPG binary
GPG=`gpgconf --list-components | grep "OpenPGP" | cut -d: -f3`

# Verify signature
$GPG --verify "$signature_filename"
