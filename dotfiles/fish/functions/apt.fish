function apt
  switch $argv[1]
    case up
      sudo aptitude update
      sudo aptitude upgrade
    case in
      sudo aptitude install $argv[2..(count $argv)]
    case rm rem
      sudo aptitude remove $argv[2..(count $argv)]
    case arm arem
      sudo aptitude autoremove
    case s search
      aptitude search $argv[2..(count $argv)]
    case '*'
      echo "Possible commands: up, in, rm, arm, s"
    end
end
