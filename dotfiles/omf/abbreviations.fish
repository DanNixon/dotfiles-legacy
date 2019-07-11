# ls commands
abbr --add --global l "ls -lFh"
abbr --add --global ll "ls -alFh"
abbr --add --global la "ls -A"
abbr --add --global ldev "ls -lFh /dev/ | grep"

# General comands
abbr --add --global die "sudo shutdown -P now"

abbr --add --global df "df -h"
abbr --add --global du "du -h"
abbr --add --global free "free -h"
abbr --add --global lb "lsblk"

abbr --add --global q "exit"
abbr --add --global c "clear"
abbr --add --global histcla "echo 'yes' | history clear"

abbr --add --global fish-add-user-path "set --universal --prepend fish_user_paths (pwd)"

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
abbr --add --global dkps "docker ps --format '{{.ID}} ~ {{.Names}} ~ {{.Status}} ~ {{.Image}}'"
abbr --add --global dkpsa "docker ps | less -S"
abbr --add --global dke "docker exec -it"
abbr --add --global dkc "docker-compose"

# Misc app stuff
abbr --add --global mm "media.sh pause"
abbr --add --global v "nvim"
abbr --add --global t "todo.sh"
abbr --add --global m "ncmpcpp"
abbr --add --global stripexif "exiftool -all= "
abbr --add --global ytdl "youtube-dl"
abbr --add --global tok "tomb open -k -"
abbr --add --global conda-init "eval $HOME/miniconda3/bin/conda 'shell.fish' 'hook' $argv | source"

# Clipboard copy and paste
abbr --add --global xcc "xclip -sel clip"
abbr --add --global xcp "xclip -sel clip -o"

# Handy for doing stuff when files change
abbr --add --global on-file-change "inotifywait -q -e modify"

# System info
abbr --add --global system-information "sudo lshw | less"
abbr --add --global b "upower -i (upower -e | grep 'BAT')"

# i3wm
abbr --add --global i3-layout-default "i3-msg layout default"
abbr --add --global i3-layout-stacking "i3-msg layout stacking"
abbr --add --global i3-layout-tabbed "i3-msg layout tabbed"

# Batch processing
abbr --add --global cmake-format-all "find . -type f -name 'CMakeLists.txt' | xargs cmake-format -i"
abbr --add --global clang-format-all "find . -type f -regex '.*\.\(c\|cpp\|h\|hpp\)' | xargs clang-format -i"
