function _powerline_section_begin
  set_color --background $argv[1]
  set_color $fish_color_normal
  set_color black
  printf ' '
end

function _powerline_section_transition
  printf ' '
  set_color $argv[1]
  set_color --background $argv[2]
  printf ''
  printf ' '
  set_color black
end

function _powerline_section_end
  set_color $argv[1]
  printf ' '
  set_color --background black
  printf ''
  set_color black
end

function fish_prompt
  set user (whoami)
  set host (hostname)

  switch $fish_bind_mode
    case default
        _powerline_section_begin $fish_color_vi_normal
        printf 'N'
        _powerline_section_transition $fish_color_vi_normal $fish_color_host
    case insert
        _powerline_section_begin $fish_color_vi_insert
        printf 'I'
        _powerline_section_transition $fish_color_vi_insert $fish_color_host
    case replace_one replace-one
        _powerline_section_begin $fish_color_vi_replace
        printf 'R'
        _powerline_section_transition $fish_color_vi_replace $fish_color_host
    case visual
        _powerline_section_begin $fish_color_vi_visual
        printf 'V'
        _powerline_section_transition $fish_color_vi_visual $fish_color_host
  end

  printf "$host"
  _powerline_section_transition $fish_color_host $fish_color_cwd
  printf "$PWD"
  _powerline_section_end $fish_color_cwd

  printf ' '
end

function fish_right_prompt
end

function fish_mode_prompt
end
