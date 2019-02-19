# Load base16-shell
if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

# Theme (bobthefish) options
set -g theme_color_scheme terminal2
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_title_display_process yes
set -g theme_display_cmd_duration yes
set -g theme_display_git_master_branch yes

# No greeting
function fish_greeting
end

# Load aliases
. ~/dotfiles/dotfiles/shell/common_aliases

# Set GPG_TTY
set --export --global GPG_TTY (tty)

# Append to PATH helper function
function fish_add_dir_to_path
  set --universal fish_user_paths $fish_user_paths $argv
end

# Execute direnv hook if it is installed
set direnv_binary (which direnv)
if test -n "$direnv_binary" -a -x "$direnv_binary"
  eval (direnv hook fish)
end
