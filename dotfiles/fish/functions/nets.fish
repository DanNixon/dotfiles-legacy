function nets
	sudo arp-scan --interface=$argv[1] --localnet
end
