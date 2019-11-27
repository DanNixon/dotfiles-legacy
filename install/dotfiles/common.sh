#!/bin/bash

C_CYAN='\033[0;36m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_RED='\033[0;31m'
C_NONE='\033[0m'

DOTFILES="$( cd "$(dirname "$0")/../.." ; pwd -P )"
printf "${C_YELLOW}\$DOTFILES=${DOTFILES}${C_NONE}\n"

function df_ensure_parent_dir_exists {
  name_parent=$(dirname "$1")
  if [ ! -d "$name_parent" ]; then
    printf "${C_GREEN}mkdir -p $name_parent${C_NONE}\n"
    mkdir -p "$name_parent"
  fi
}

function df_get_patch_filename {
  base_file="$1"
  patch_target=${PATCH_TARGET:-$(hostname)}
  echo "$base_file.$patch_target.patch"
}

function df_link {
  src="$1"
  dest="$2"

  df_ensure_parent_dir_exists "$dest"

  # Check if the destination is already a symlink
  if [ -L "$dest" ]; then
    # Check if it points to the correct place
    if [[ "$dest" -ef "$src" ]]; then
      printf "${C_GREEN}Link ${dest} => ${src}${C_NONE}\n"
      return 0
    else
      printf "{C_CYAN}${dest}${C_NONE} : ${C_YELLOW}Incorrect link${C_NONE}\n"
      return 1
    fi
  fi

  # Check if the destination is an existing file
  if [ -f "$dest" ]; then
    printf "{C_CYAN}${dest}${C_NONE} : ${C_RED}Existing file${C_NONE}\n"
    return 2
  fi

  # Check if the destimation is an existing directory
  if [ -d "$dest" ]; then
    printf "{C_CYAN}${dest}${C_NONE} : ${C_RED}Existing directory${C_NONE}\n"
    return 2
  fi

  # Link did not exist, should be OK to create it now
  printf "${C_GREEN}Link ${dest} => ${src}${C_NONE}\n"
  ln -s "$src" "$dest"
}

function df_copy {
  src="$1"
  dest="$2"

  df_ensure_parent_dir_exists "$dest"

  printf "${C_GREEN}Copy ${src} => ${dest}${C_NONE}\n"
  cp -r "$src" "$dest"
}

function df_patch_and_copy {
  src="$1"
  dest="$2"

  # Check destination either does not exist, or exists and is a regular file, not a symlink
  if [ -e "$dest" -a ! -f "$dest" -o -h "$dest" ]; then
    printf "${C_RED}Destination file must not exists or be a regular file: ${dest}${C_NONE}\n"
    return 1
  fi

  df_ensure_parent_dir_exists "$dest"

  # Search for candidate patch files
  patch_filename=$(df_get_patch_filename "$src")
  if [ -f "$patch_filename" ]; then
    # Copy source file
    patched=$(mktemp)
    cp "$src" "$patched"

    # Apply patch
    printf "${C_YELLOW}Patching copy of ${src} with ${patch_filename}${C_NONE}\n"
    patch "$patched" "$patch_filename"

    # Move patched file to destination
    printf "${C_GREEN}Move ${patched} => ${dest}${C_NONE}\n"
    mv "$patched" "$dest"
  else
    # If no patch then just copy the original file to destination
    printf "${C_GREEN}Copy ${src} => ${dest}${C_NONE}\n"
    cp "$src" "$dest"
  fi
}

function df_update_patch {
  src="$1"
  dest="$2"

  # Check if destination is an existing file
  if [ ! -f "$dest" ]; then
    printf "${C_RED}Destination file does not exist${C_NONE}\n"
    return 1
  fi

  patch_filename=$(df_get_patch_filename "$src")

  # Create patch
  diff "$src" "$dest" > "$patch_filename"

  # Check if the patch actually has any changes
  if [ -s "$patch_filename" ]; then
    printf "${C_GREEN}Created patch ${patch_filename}${C_NONE}\n"
  else
    printf "${C_YELLOW}Created patch was empty so was not kept${C_NONE}\n"
    rm "$patch_filename"
  fi
}

function df_add_secrets {
  filename="$1"

  # Find everything that matches "<< pass something >>" and replace it with the value of something from pass
  for password in $(perl -ne 'while(/<< pass ([\w\/]+) >>/g){print "$1\n";}' "$filename" | sort --unique); do
    echo $password
    perl -pe "s{<< pass $password >>}{$(pass "$password")}" -i $filename
  done
}
