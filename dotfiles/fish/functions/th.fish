function th
  cd ~/apps/Touhou
  switch $argv
    case 6
    	cd Touhou60
      wine th06.exe & exit
    case 7
    	cd Touhou70
      wine th07.exe & exit
    case 7.5
    	cd Touhou75
      wine th75.exe & exit
    case 8
    	cd Touhou80
      wine th08.exe & exit
    case 9
    	cd Touhou90
      wine th09.exe & exit
    case 9.5
    	cd Touhou95
      wine th095.exe & exit
    case 10
    	cd Touhou100
      wine th10.exe & exit
    case 10.5
    	cd Touhou105
      wine th105.exe & exit
    case 11
    	cd Touhou110
      wine th11.exe & exit
    case 12
    	cd Touhou120
      wine th12.exe & exit
    case 12.3
    	cd Touhou123
      wine th123.exe & exit
    case 12.5
    	cd Touhou125
      wine th125.exe & exit
    case 12.8
    	cd Touhou128
      wine th128.exe & exit
    case 13
    	cd Touhou130
      wine th13.exe & exit
    case "list" "ls"
      ls
  end
end
