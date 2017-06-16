# Load aliases
. ~/dotfiles/dotfiles/shell/common_aliases

function fish_add_dir_to_path
  set --universal fish_user_paths $fish_user_paths $argv
end

function b
  upower -i (upower -e | grep 'BAT') | grep -E "state|time\ to|percentage|energy-rate" --color=never
end

# Init VirtualFish
eval (python -m virtualfish)

# No greeting
function fish_greeting
end
