export EDITOR='nvim'

export TODOTXT_DEFAULT_ACTION='ls'

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

export PATH="$HOME/dotfiles/scripts/:$HOME/dotfiles/third_party/scripts/:$HOME/dotfiles/third_party/bin/:$PATH"
