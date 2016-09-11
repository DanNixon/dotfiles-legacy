# Load aliases
. ~/dotfiles/dotfiles/shell/common_aliases

function fish_add_dir_to_path
  set --universal fish_user_paths $fish_user_paths $argv
end

# Add scripts to path
set -U fish_user_paths $fish_user_paths ~/dotfiles/scripts

# Init VirtualFish
eval (python -m virtualfish)

# No greeting
function fish_greeting
end
