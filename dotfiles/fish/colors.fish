if status --is-interactive
  # Load base16-shell
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"

  set -g fish_color_normal white
  set -g fish_color_command white --bold
  set -g fish_color_quote green
  set -g fish_color_redirection yellow
  set -g fish_color_end yellow
  set -g fish_color_error red
  set -g fish_color_param blue
  set -g fish_color_comment white
  # set -g fish_color_match
  # set -g fish_color_selection
  # set -g fish_color_search_match
  # set -g fish_color_operator
  # set -g fish_color_escape
  set -g fish_color_cwd brblack
  set -g fish_color_autosuggestion brblack
  set -g fish_color_user brblack
  set -g fish_color_host brblack
  set -g fish_color_cancel red --bold

  set -g fish_color_vi_normal blue
  set -g fish_color_vi_insert green
  set -g fish_color_vi_replace red
  set -g fish_color_vi_visual yellow
end
