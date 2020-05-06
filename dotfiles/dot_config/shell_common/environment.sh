export EDITOR='nvim'

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

export TODO_DIR="$HOME/docs/markor"
export NOTE_DIR="$HOME/docs/markor"
export VOILE_BOOKMARK_FILE="/media/personal/bookmarks/bookmarks.json"

export PATH="$HOME/dotfiles/scripts/:$HOME/.local/bin/:$HOME/dotfiles/third_party/scripts/:$HOME/dotfiles/third_party/bin/:$PATH"
