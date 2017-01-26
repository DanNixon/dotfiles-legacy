# Load aliases
. ~/dotfiles/dotfiles/shell/common_aliases

function fish_add_dir_to_path
  set --universal fish_user_paths $fish_user_paths $argv
end

# Init VirtualFish
eval (python -m virtualfish)

# No greeting
function fish_greeting
end
