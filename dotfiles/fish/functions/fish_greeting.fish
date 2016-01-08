function fish_greeting
  set -l day (date '+%d')
  set -l type (math $day%3)
  switch $type
    case 0
    	fortune ~/dotfiles/fortune/yandere
    case 1
    	fortune ~/dotfiles/fortune/tsundere
    case 2
    	fortune ~/dotfiles/fortune/mysterious
  end
end
