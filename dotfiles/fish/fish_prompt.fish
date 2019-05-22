function _powerline_section_begin --no-scope-shadowing
  set bg $argv[1]

  set_color --background $argv[1]
  set_color normal

  switch "$__powerline_current_background"
    case ''
      # If there's no background, just start one
      set_color --background $bg
      printf ' '
    case "$bg"
      # If the background is already the same color, draw a separator
      set_color --background $__powerline_current_background
      printf '  '
    case '*'
      # otherwise, draw the end of the previous segment and the start of the next
      set_color --background $__powerline_current_background
      printf ' '
      set_color $__powerline_current_background
      set_color --background $bg
      printf ' '
  end

  set __powerline_current_background $bg
end

function fish_prompt
  set -l __powerline_current_background

  set user (whoami)
  set host (hostname)

  switch $fish_bind_mode
    case default
        _powerline_section_begin $fish_color_vi_normal
        set_color brblack --bold
        printf 'N'
    case insert
        _powerline_section_begin $fish_color_vi_insert
        set_color brblack --bold
        printf 'I'
    case replace_one replace-one
        _powerline_section_begin $fish_color_vi_replace
        set_color brblack --bold
        printf 'R'
    case visual
        _powerline_section_begin $fish_color_vi_visual
        set_color brblack --bold
        printf 'V'
  end

  _powerline_section_begin $fish_color_host
  set_color white
  printf "$host"

  _powerline_section_begin $fish_color_cwd
  set_color white
  printf "$PWD"

  _powerline_section_begin black

  set_color normal
end

function fish_right_prompt
end

function fish_mode_prompt
end
