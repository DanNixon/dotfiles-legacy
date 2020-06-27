alias -g fwd-gpg='-R /run/user/1000/gnupg/S.gpg-agent:$(gpgconf --list-dirs agent-extra-socket)'
alias -g fwd-nd='-L localhost:29999:localhost:19999'
alias -g fwd-st='-L localhost:9999:localhost:8384'
