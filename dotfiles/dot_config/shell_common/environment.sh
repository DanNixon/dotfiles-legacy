export EDITOR='nvim'

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

export TODO_DIR="$HOME/docs/markor"
export TODOTXT_DEFAULT_ACTION='ls'

export VOILE_BOOKMARK_FILE="/media/personal/bookmarks/bookmarks.json"

export TILE_USERNAME="<< pass Passwords/Internet/Tile/Email >>"

export DARKSKY_API_KEY="<< pass ShellSecrets/DARKSKY_API_KEY >>"

export PATH="$HOME/dotfiles/scripts/:$HOME/.local/bin/:$HOME/dotfiles/third_party/scripts/:$HOME/dotfiles/third_party/bin/:$PATH"
