FROM ubuntu:bionic

# Install APT packages and cleanup
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:fish-shell/release-2 && \
    apt-get update && \
    apt-get install -y language-pack-en fish git wget curl secure-delete htop tree exuberant-ctags mosh python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Neovim
RUN curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
    tar xf nvim.tar.gz -C /usr --strip-components=1 && \
    rm nvim.tar.gz

# Install Python packages
RUN pip3 install neovim numpy ipython

# Add user
RUN useradd --create-home --uid 10000 --shell /usr/bin/fish dan

# Set entry script
COPY init.sh /init.sh
ENTRYPOINT ["/init.sh"]

WORKDIR /home/dan
CMD ["/usr/bin/fish"]
