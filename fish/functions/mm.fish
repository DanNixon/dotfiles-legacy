function mm
  set -l host (hostname -s)
  if [ $host = "dan-desktop" ]
    switch $argv[1]
      case d dual
        xrandr --output VIRTUAL1 --off --output DP1 --off --output DVI-D-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-D-2 --off --output HDMI1 --off --output DVI-I-1 --mode 1440x900 --pos 1920x0 --rotate normal --output VGA1 --off
      case s single
        xrandr --output VIRTUAL1 --off --output DP1 --off --output DVI-D-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-D-2 --off --output HDMI1 --off --output DVI-I-1 --off --output VGA1 --off
     end
  end
end
