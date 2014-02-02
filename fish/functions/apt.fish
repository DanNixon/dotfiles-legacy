function apt
  switch $argv[1]
    case up
      sudo apt-get update
      sudo apt-get upgrade
    case in
      sudo apt-get update
      sudo apt-get install $argv[2..(count $argv)]
    case rm rem
      sudo apt-get remove $argv[2..(count $argv)]
    case arm arem
      sudo apt-get autoremove
    case '*'
      echo "Possible commands: up, in, rm, arm"
    end
end
