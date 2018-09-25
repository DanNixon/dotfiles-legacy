FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y software-properties-common curl git

RUN add-apt-repository -y ppa:fish-shell/release-2 && \
    apt-get update && \
    apt-get install -y fish secure-delete htop tree neovim exuberant-ctags

RUN useradd --create-home dan && \
    adduser dan sudo

USER dan
WORKDIR /home/dan

RUN git clone https://github.com/dannixon/dotfiles.git && \
    cd dotfiles && \
    ./install main && \
    ./install fish && \
    nvim --headless -c PlugInstall -c q -c q

ENTRYPOINT /usr/bin/fish
