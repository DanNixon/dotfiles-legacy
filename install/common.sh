#!/bin/bash

function df_print_info {
  printf '\033[0;36mINFO\033[0m: %s\n' "$1"
}

function df_print_bad {
  printf '\033[0;31mFAIL\033[0m: %s\n' "$1"
}

function df_print_warn {
  printf '\033[0;33mWARN\033[0m: %s\n' "$1"
}

function df_print_good {
  printf '\033[0;32m-OK-\033[0m: %s\n' "$1"
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
  patch_target=${PATCH_TARGET:-$HOSTNAME}
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

function df_target {
  operation="$1"
  user_action="$2"

  if [[ "$user_action" == "install" ]]; then
    # If we are installing then just do the thing
    echo "df_$operation"
  elif [[ "$user_action" == "update" ]] && [[ "$operation" == "copy_patched" ]]; then
    # If we are updating the repo, do nothing unless it was a patch target, in which case update it
    echo "df_update_patch"
  else
    # Do nothing if the arguments are not sensible
    echo "df_noop"
  fi
}

function df_exit_if_not_install {
  # Exit if the user did not specify "install"
  # Useful for extra actons that do not use a df_ target
  if [[ "$1" != "install" ]]; then
    exit 0
  fi
}
