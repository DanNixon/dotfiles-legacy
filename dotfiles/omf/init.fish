# Load aliases
. ~/dotfiles/dotfiles/shell/common_aliases

# No greeting
function fish_greeting
end

# Append to PATH helper function
function fish_add_dir_to_path
  set --universal fish_user_paths $fish_user_paths $argv
end

# Print voile output via less
function bmless
  voile $argv | less -r
end

# Battery status
function b
  upower -i (upower -e | grep 'BAT') | grep -E "state|time\ to|percentage|energy-rate" --color=never
end

# Environment Modules
set modules_path /usr/local/Modules/
if test -d $modules_path;
  . $modules_path"init/fish"
  . $modules_path"init/fish_completion"
end
