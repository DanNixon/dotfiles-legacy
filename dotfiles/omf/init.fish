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
  set -g theme_display_cmd_duration no

  # Colors
  set -g fish_color_normal white
  set -g fish_color_command white --bold
  set -g fish_color_quote green
  set -g fish_color_redirection yellow
  set -g fish_color_end yellow
  set -g fish_color_error red
  set -g fish_color_param blue
  set -g fish_color_comment white
  set -g fish_color_cancel red --bold
  set -g fish_color_operator yellow
  set -g fish_color_escape cyan

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
