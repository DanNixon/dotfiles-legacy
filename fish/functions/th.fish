function th
  cd ~/apps/Touhou
  switch $argv
    case 6
    	cd Touhou60
      wine th06e.exe & exit
    case 7
    	cd Touhou70
      wine th07e.exe & exit
    case 8
    	cd Touhou80
      wine th08.exe & exit
  end
end
