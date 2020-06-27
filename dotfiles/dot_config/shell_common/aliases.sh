alias l="ls --color=auto -lFh"
alias ll="ls --color=auto -lFa"

alias df="df -h"
alias du="du -h"

alias lb="lsblk"

alias q="exit"
alias c="clear"

alias ..="cd .."

alias bm="voile"
alias bmadd="voile add -cae"

alias zfs-ls="zfs list -o name,referenced,used,available,encryption,keystatus,mounted,mountpoint"

alias cmake-format-all="find . -type f -name 'CMakeLists.txt' | xargs cmake-format -i"
alias clang-format-all="find . -type f -regex '.*\.\(c\|cpp\|h\|hpp\)' | xargs clang-format -i"

alias open="xdg-open"
alias g="git"
alias v="$EDITOR"
alias t="todo.sh"
alias m="ncmpcpp"
alias stripexif="exiftool -all="
alias tok="tomb open -k -"
alias on-file-change="inotifywait -q -e modify"
alias fif="grep -rnw . -e"
alias netstat-list-listening-ports="netstat --tcp --udp --listening --numeric --program"
alias nb="newsboat"
alias pb="podboat"
alias nm="neomutt"

alias today="date '+%Y-%m-%d'"
