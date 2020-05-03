export EDITOR='nvim'

export GPG_TTY="$(tty)"

# Check if a SSH agent is already set (e.g. via agent forwarding)
if [ -z ${SSH_AUTH_SOCK+x} ]; then
  # Use gpg-agent as SSH agent
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export TODO_DIR="$HOME/docs/markor"
export NOTE_DIR="$HOME/docs/markor"
export VOILE_BOOKMARK_FILE="/media/personal/bookmarks/bookmarks.json"

export PATH="$HOME/dotfiles/scripts/:$HOME/.local/bin/:$HOME/dotfiles/third_party/scripts/:$HOME/dotfiles/third_party/bin/:$PATH"
