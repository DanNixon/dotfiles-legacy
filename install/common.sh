#!/bin/bash

C_NONE='\033[0m'

function df_print_info {
  msg="$1"
  C_CYAN='\033[0;36m'
  printf "${C_CYAN}INFO${C_NONE}: ${msg}\n"
}

function df_print_bad {
  msg="$1"
  C_RED='\033[0;31m'
  printf "${C_RED}FAIL${C_NONE}: ${msg}\n"
}

function df_print_warn {
  msg="$1"
  C_YELLOW='\033[0;33m'
  printf "${C_YELLOW}WARN${C_NONE}: ${msg}\n"
}

function df_print_good {
  msg="$1"
  C_GREEN='\033[0;32m'
  printf "${C_GREEN}-OK-${C_NONE}: ${msg}\n"
}

DOTFILES="$( cd "$(dirname "$0")/.." ; pwd -P )"
df_print_info "Dotfiles directory is \"$DOTFILES\""

function df_ensure_parent_dir_exists {
  name_parent=$(dirname "$1")
  if [ ! -d "$name_parent" ]; then
    df_print_info "mkdir -p $name_parent"
    mkdir -p "$name_parent"
  fi
}

function df_get_patch_filename {
  base_file="$1"
  patch_target=${PATCH_TARGET:-$(hostname)}
  echo "$base_file.$patch_target.patch"
}

function df_noop {
  df_print_info "No Op"
}

function df_link {
  src="$1"
  dest="$2"

  df_ensure_parent_dir_exists "$dest"

  # Check if the destination is already a symlink
  if [ -L "$dest" ]; then
    # Check if it points to the correct place
    if [[ "$dest" -ef "$src" ]]; then
      df_print_good "Link ${dest} => ${src}"
      return 0
    else
      df_print_bad "${dest} : Incorrect link"
      return 1
    fi
  fi

  # Check if the destination is an existing file
  if [ -f "$dest" ]; then
    df_print_bad "${dest} : Existing file"
    return 2
  fi

  # Check if the destimation is an existing directory
  if [ -d "$dest" ]; then
    df_print_bad "${dest} : Existing directory"
    return 2
  fi

  # Link did not exist, should be OK to create it now
  df_print_good "Link ${dest} => ${src}"
  ln -s "$src" "$dest"
}

function df_copy {
  src="$1"
  dest="$2"

  df_ensure_parent_dir_exists "$dest"

  df_print_good "Copy ${dest} => ${src}"
  cp -r "$src" "$dest"
}

function df_copy_patched {
  src="$1"
  dest="$2"

  # Check destination either does not exist, or exists and is a regular file, not a symlink
  if [ -e "$dest" -a ! -f "$dest" -o -h "$dest" ]; then
    df_print_bad "Destination file must not exists or be a regular file: ${dest}"
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
    df_print_info "Patching copy of ${src} with ${patch_filename}"
    patch "$patched" "$patch_filename"

    # Move patched file to destination
    df_print_good "Move patched ${patched} => ${src}"
    mv "$patched" "$dest"
  else
    # If no patch then just copy the original file to destination
    df_print_good "Copy ${dest} => ${src}"
    cp "$src" "$dest"
  fi
}

function df_update_patch {
  src="$1"
  dest="$2"

  # Check if destination is an existing file
  if [ ! -f "$dest" ]; then
    df_print_bad "Destination file does not exist"
    return 1
  fi

  patch_filename=$(df_get_patch_filename "$src")

  # Create patch
  diff "$src" "$dest" > "$patch_filename"

  # Check if the patch actually has any changes
  if [ -s "$patch_filename" ]; then
    df_print_good "Created patch ${patch_filename}"
  else
    df_print_warn "Created patch was empty so was not kept"
    rm "$patch_filename"
  fi
}

function df_add_secrets {
  filename="$1"

  # Find everything that matches "<< pass something >>" and replace it with the value of something from pass
  for password in $(perl -ne 'while(/<< pass ([\w\/]+) >>/g){print "$1\n";}' "$filename" | sort --unique); do
    df_print_info "Inject secret ${password}"
    pw="$(pass "$password")" perl -pe 's{<< pass '"$password"' >>}{$ENV{pw}}' -i $filename
  done
}

function df_target {
  operation="$1"
  user_action="$2"

  if [[ "$user_action" == "install" ]]; then
    echo "df_$operation"
  elif [[ "$user_action" == "update" ]] && [[ "$operation" == "copy_patched" ]]; then
    echo "df_update_patch"
  else
    echo "df_noop"
  fi
}

function df_exit_if_not_install {
  user_action="$1"
  if [[ "$user_action" != "install" ]]; then
    exit 0
  fi
}
