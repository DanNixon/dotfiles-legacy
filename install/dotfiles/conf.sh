#!/bin/bash

C_CYAN='\033[0;36m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_RED='\033[0;31m'
C_NONE='\033[0m'

DOTFILES="$( cd "$(dirname "$0")/../.." ; pwd -P )"
printf "${C_YELLOW}\$DOTFILES=${DOTFILES}${C_NONE}\n"

function ensure_parent_dir_exists {
  name_parent=$(dirname "$1")
  if [ ! -d "$name_parent" ]; then
    printf "${C_GREEN}mkdir -p $name_parent${C_NONE}\n"
    mkdir -p "$name_parent"
  fi
}

function df_link {
  target="$1"
  name="$2"

  ensure_parent_dir_exists "$name"

  printf "${C_CYAN}${name}${C_NONE} : "

  # Check if the name is already a symlink
  if [ -L "$name" ]; then
    # Check if it points to the correct place
    if [[ "$name" -ef "$target" ]]; then
      printf "${C_GREEN}✓${C_NONE}\n"
      return 0
    else
      printf "${C_YELLOW}Incorrect link${C_NONE}\n"
      return 1
    fi
  fi

  # Check if the name is an existing file
  if [ -f "$name" ]; then
    printf "${C_RED}Existing file${C_NONE}\n"
    return 2
  fi

  # Check if the name is an existing directory
  if [ -d "$name" ]; then
    printf "${C_RED}Existing directory${C_NONE}\n"
    return 2
  fi

  # Link did not exist, should be OK to create it now
  printf "${C_GREEN}Link ${name} => ${target}${C_NONE}\n"
  ln -s "$target" "$name"
}

function shell_aliases {
  shell="$1"
  name="$2"

  ensure_parent_dir_exists "$name"

  printf "${C_CYAN}${name}${C_NONE} : $shell shell aliases ${C_GREEN}✓${C_NONE}\n"
  cat "$DOTFILES/dotfiles/shell_aliases.txt" | "$DOTFILES/scripts/format-shell-aliases" "$shell" > "$name"
}
