# No greeting
function fish_greeting
end

# Set environment
set --export --global GPG_TTY (tty)

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

  set -g fish_color_normal  white --bold
  set -g fish_color_command white --bold
  set -g fish_color_quote green
  set -g fish_color_redirection brown
  set -g fish_color_end white --bold
  set -g fish_color_error red
  set -g fish_color_param blue
  set -g fish_color_comment white
  # set -g fish_color_match white
  # set fish_color_selection
  # set fish_color_search_match
  # set fish_color_operator
  # set fish_color_escape
  # set fish_color_cwd
  # set fish_color_autosuggestion
  # set fish_color_user
  # set fish_color_host
  set -g fish_color_cancel red --bold

  # Use Vi key bindings
  fish_vi_key_bindings

  # Execute direnv hook if it is installed
  if command -s direnv > /dev/null
    eval (direnv hook fish)
  end

  # Set interactive environment
  set --export --global EDITOR nvim
  set --export --global TODOTXT_DEFAULT_ACTION ls

  # Load abbreviations
  source "$OMF_CONFIG/abbreviations.fish"
end
