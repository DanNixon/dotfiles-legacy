SHELL=/bin/bash

all: vim bash_aliases git weechat terminator putty screen lynx skeinforge i3 gdb

clean: clean_vim_links clean_fish clean_bash_aliases clean_git clean_weechat clean_terminator clean_putty clean_screen clean_lynx clean_skeinforge clean_i3 clean_gdb

#vim
vim: vim_links
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim +BundleInstall! +BundleClean +qall

vim_links:
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/vim ~/.vim

clean_vim_links:
	rm ~/.vimrc
	rm ~/.vim

#fish
fish: clean_fish
	ln -s ~/dotfiles/fish/ ~/.config/fish
	chsh -s /usr/bin/fish

clean_fish:
	rm -r ~/.config/fish

#bash_aliases
bash_aliases:
	ln -s ~/dotfiles/shell/bash_aliases ~/.bash_aliases

clean_bash_aliases:
	rm ~/.bash_aliases

#git
git:
	ln -s ~/dotfiles/gitconfig ~/.gitconfig

clean_git:
	rm ~/.gitconfig

#weechat
weechat:
	ln -s ~/dotfiles/weechat/ ~/.weechat

clean_irssi:
	rm ~/.weechat

#terminator
terminator:
	ln -s ~/dotfiles/terminator/ ~/.config/terminator

clean_terminator:
	rm ~/.config/terminator

#putty
putty:
	ln -s ~/dotfiles/putty_serial_sessions/ ~/.putty/sessions

clean_putty:
	rm ~/.putty/sessions

#screen
screen:
	ln -s ~/dotfiles/screenrc ~/.screenrc

clean_screen:
	rm ~/.screenrc

#lynx
lynx:
	ln -s ~/dotfiles/lynxrc ~/.lynxrc

clean_lynx:
	rm ~/.lynxrc

#skeinforge
skeinforge:
	ln -s ~/dotfiles/skeinforge/ ~/.skeinforge

clean_skeinforge:
	rm ~/.skeinforge

#i3
i3:
	mkdir -p ~/.i3
	cd i3; \
		./generate_config
	i3-msg reload

clean_i3:
	rm -r ~/.i3
	rm ~/.i3status.conf

refresh_i3: clean_i3 i3
	i3-msg restart

#GDB
gdb:
	ln -s ~/dotfiles/gdb/gdbinit ~/.gdbinit
	ln -s ~/dotfiles/gdb/gdb/ ~/.gdb

clean_gdb:
	rm ~/.gdbinit
	rm ~/.gdb
