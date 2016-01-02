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
