function __fish_powerline_being_section --no-scope-shadowing
  set side $argv[1]
  set bg $argv[2]
  set fg $argv[3..-1]

  switch "$side"
    case 'left'
      set powerline_filled ''
      set powerline_thin ''
    case 'right'
      set powerline_filled ''
      set powerline_thin ''
  end

  switch "$powerline_current_bg_color"
    case ''
      # If there's no background, just start one
      set_color --background $bg
      printf ' '
    case "$bg"
      # If the background is already the same color, draw a separator
      __fish_powerline_set_bg_color
      set_color $fg
      printf " $powerline_thin "
    case '*'
      # otherwise, draw the end of the previous segment and the start of the next
      __fish_powerline_set_bg_color
      printf ' '
      set_color $powerline_current_bg_color
      set_color --background $bg
      printf "$powerline_filled "
  end

  set powerline_current_bg_color $bg

  set_color $fg
end

function __fish_powerline_set_bg_color --no-scope-shadowing
  set_color normal
  set_color --background $powerline_current_bg_color
end

function fish_prompt
  set -l powerline_current_bg_color

  set user (whoami)
  set host (hostname)

  # Vi mode status
  switch $fish_bind_mode
    case default
      set vi_mode_color $fish_color_vi_normal
      set vi_mode_letter 'N'
    case insert
      set vi_mode_color $fish_color_vi_insert
      set vi_mode_letter 'I'
    case replace_one replace-one
      set vi_mode_color $fish_color_vi_replace
      set vi_mode_letter 'R'
    case visual
      set vi_mode_color $fish_color_vi_visual
      set vi_mode_letter 'V'
  end
  __fish_powerline_being_section 'left' $vi_mode_color brblack --bold
  printf "$vi_mode_letter"

  # User and hostname
  __fish_powerline_being_section 'left' $fish_color_user_host_bg
  set_color $fish_color_user
  printf "$user"
  __fish_powerline_set_bg_color
  set_color $fish_color_host
  printf "@$host"

  # Current working directory
  __fish_powerline_being_section 'left' $fish_color_cwd_bg $fish_color_cwd
  printf "$PWD"

  # Prompt
  __fish_powerline_being_section 'left' black normal
end

function fish_right_prompt
  set last_status $status

  # Last command exit code
  if [ $last_status != '0' ]
    __fish_powerline_being_section 'right' black $fish_color_error
    printf "$last_status"
  end

  # Date and time
  __fish_powerline_being_section 'right' black brblack
  date
end

function fish_mode_prompt
  # Disable separate Vi mode prompt (handled in fish_prompt)
end
