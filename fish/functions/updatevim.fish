function updatevim
	set SHELL (which sh)
    vim +BundleInstall! +BundleClean +qall
    set SHELL (which fish)
end
