function fish_prompt --description 'Write out the prompt'
  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end
  
  function _is_git_dirty
    echo (git status -s --ignore-submodules=dirty ^/dev/null)
  end
  
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

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_is_git_dirty) ]
      set -l yellow (set_color -o yellow)
      set dirty " $yellow✗"
    end

    set -l col_cwd (set_color $fish_color_cwd)
    set -l col_norm (set_color normal)
    echo -n " ($col_cwd$git_branch$dirty$col_norm)"
  end

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '> '
  set_color normal
end
