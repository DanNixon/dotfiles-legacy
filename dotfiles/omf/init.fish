# Set environment
set --export --global GPG_TTY (tty)
set --export --global SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# No greeting
function fish_greeting
end

if status --is-interactive
  # Load base16-shell
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"

  # Theme (bobthefish) options
  set -g theme_color_scheme terminal2
  set -g theme_powerline_fonts yes
  set -g theme_nerd_fonts yes
  set -g theme_title_display_process yes
  set -g theme_display_cmd_duration yes
  set -g theme_display_git_master_branch yes
  set -g theme_show_exit_status yes

  # Use Vi key bindings
  fish_vi_key_bindings

  # Execute direnv hook if it is installed
  if command -s direnv > /dev/null
    eval (direnv hook fish)
  end

  # Set interactive environment
  set --export --global EDITOR nvim
  set --export --global TODOTXT_DEFAULT_ACTION ls

  source "$OMF_CONFIG/abbreviations.fish"
end
