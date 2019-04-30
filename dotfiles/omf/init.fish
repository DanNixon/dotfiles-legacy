# No greeting
function fish_greeting
end

# Append to PATH helper function
function fish_add_dir_to_path
  set --universal fish_user_paths $fish_user_paths (pwd)
end

# Set environment
set --export --global GPG_TTY (tty)

if status --is-interactive
  # Load base16-shell
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"

  # Theme (bobthefish) options
  set -g theme_color_scheme terminal2
  set -g theme_powerline_fonts yes
  set -g theme_nerd_fonts yes
  set -g theme_title_display_process yes
  set -g theme_display_cmd_duration yes
  set -g theme_display_git_master_branch yes

  # Use Vi key bindings
  fish_vi_key_bindings

  # Execute direnv hook if it is installed
  if command -s direnv > /dev/null
    eval (direnv hook fish)
  end

  # Set interactive environment
  set --export --global EDITOR nvim
  set --export --global TODOTXT_DEFAULT_ACTION ls

  # ls commands
  abbr --add --global l "ls -lFh"
  abbr --add --global ll "ls -alFh"
  abbr --add --global la "ls -A"
  abbr --add --global ldev "ls -lFh /dev/ | grep"
  abbr --add --global lmedia "tree -d -L 2 /media"

  # General comands
  abbr --add --global die "sudo shutdown -P now"

  abbr --add --global df "df -h"
  abbr --add --global du "du -h"
  abbr --add --global free "free -h"
  abbr --add --global lb "lsblk"

  abbr --add --global q "exit"
  abbr --add --global c "clear"
  abbr --add --global histcla "echo 'yes' | history clear"

  # Git commands
  abbr --add --global g "git"
  abbr --add --global gs "git s"

  # Directory commands
  abbr --add --global .. "cd .."

  # Finding commands
  abbr --add --global fif "grep -rnw . -e"

  # udisks
  abbr --add --global udm "udisksctl mount -b"
  abbr --add --global udum "udisksctl unmount -b"

  # Screen
  abbr --add --global s "screen"
  abbr --add --global sls "screen -ls"
  abbr --add --global ss "screen -S"

  # Bookmarks
  abbr --add --global bm "voile"
  abbr --add --global bmadd "voile add -cae"

  # Docker
  abbr --add --global dk "docker"
  abbr --add --global dkc "docker-compose"
  abbr --add --global dkps "docker ps --format '{{.ID}} ~ {{.Names}} ~ {{.Status}} ~ {{.Image}}'"
  abbr --add --global dkpsa "docker ps | less -S"
  abbr --add --global dke "docker exec -it"

  # Misc app stuff
  abbr --add --global v "nvim"
  abbr --add --global t "todo.sh"
  abbr --add --global m "ncmpcpp"
  abbr --add --global stripexif "exiftool -all= "
end
