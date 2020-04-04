alias l="ls --color=auto -lFh"
alias ll="ls --color=auto -lFa"
alias ldev="ls --color=auto -lF /dev/ | grep"

alias df="df -h"
alias du="du -h"
alias free="free -h"

alias lb="lsblk"

alias q="exit"
alias c="clear"

alias ..="cd .."

alias udm="udisksctl mount -b"
alias udum="udisksctl unmount -b"

alias xcc="xclip -sel clip"
alias xcp="xclip -sel clip -o"

alias g="git"
alias gs="git s"

alias i3-layout-default="i3-msg layout default"
alias i3-layout-stacking="i3-msg layout stacking"
alias i3-layout-tabbed="i3-msg layout tabbed"

alias bm="voile"
alias bmadd="voile add -cae"

alias zfs-ls="zfs list -o name,referenced,used,available,encryption,keystatus,mounted,mountpoint"
alias zps="zpool status"

alias cmake-format-all="find . -type f -name 'CMakeLists.txt' | xargs cmake-format -i"
alias clang-format-all="find . -type f -regex '.*\.\(c\|cpp\|h\|hpp\)' | xargs clang-format -i"

alias v="nvim"
alias t="todo.sh"
alias m="ncmpcpp"
alias stripexif="exiftool -all="
alias tok="tomb open -k -"
alias on-file-change="inotifywait -q -e modify"
alias b="upower -e | grep 'BAT' | xargs upower -i"
alias fif="grep -rnw . -e"
alias ytdl="youtube-dl"
alias netstat-list-listening-ports="netstat --tcp --udp --listening --numeric --program"
alias tile-locate="pass Passwords/Internet/Tile/Password | xargs tile-locate --password"
alias nb="newsboat"

alias today="date '+%Y-%m-%d'"
