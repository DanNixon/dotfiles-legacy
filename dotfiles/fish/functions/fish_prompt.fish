function fish_prompt --description 'Write out the prompt'
  set -g __fish_git_prompt_show_informative_status 1
  set -g __fish_git_prompt_hide_untrackedfiles 1

  set -g __fish_git_prompt_color_branch magenta
  set -g __fish_git_prompt_showupstream "informative"
  set -g __fish_git_prompt_char_upstream_ahead "↑"
  set -g __fish_git_prompt_char_upstream_behind "↓"
  set -g __fish_git_prompt_char_upstream_prefix ""

  set -g __fish_git_prompt_char_stagedstate "●"
  set -g __fish_git_prompt_char_dirtystate "✚"
  set -g __fish_git_prompt_char_untrackedfiles "…"
  set -g __fish_git_prompt_char_conflictedstate "✖"
  set -g __fish_git_prompt_char_cleanstate "✔"

  set -g __fish_git_prompt_color_dirtystate blue
  set -g __fish_git_prompt_color_stagedstate yellow
  set -g __fish_git_prompt_color_invalidstate red
  set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal

	set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ' '

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  echo -n (__fish_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '> '
  set_color normal
end
