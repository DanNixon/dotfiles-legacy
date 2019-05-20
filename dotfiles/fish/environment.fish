# Set environment
set --export --global GPG_TTY (tty)
set --export --global SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

if status --is-interactive
  # Use Vi key bindings
  fish_vi_key_bindings

  # Execute direnv hook if it is installed
  if command -s direnv > /dev/null
    eval (direnv hook fish)
  end

  # Set interactive environment
  set --export --global EDITOR nvim
  set --export --global TODOTXT_DEFAULT_ACTION ls
end
