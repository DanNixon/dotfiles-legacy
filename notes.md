# Notes

## Setting environment variables in Fish

```
set -Ux [VARIABLE] [VALUE]
```

## Setting Fish PATH

```
set --universal fish_user_paths $fish_user_paths ~/path/name
```

https://github.com/fish-shell/fish-shell/issues/527#issuecomment-32237807

## No toolbar in OpenSCAD

Remove the `appmenu-qt5` package.

https://bugs.launchpad.net/ubuntu/+source/appmenu-qt5/+bug/1307619

## PGP smart card

- `apt install scdaemon pcscd pcsc-tools`
- `pcsc_scan -n`

Reader can be manually selected in `.gnupg/scdaemon.conf` using `reader-port` if
needed.

## Laptop backlight not adjustable

Check `/sys/class/backlight` first.

Assuming `intel_backlight` is listed, create the file
`/usr/share/X11/xorg.conf.d/20-intel.conf` with the contents:

```
Section "Device"
        Identifier  "card0"
        Driver      "intel"
        Option      "Backlight"  "intel_backlight"
        BusID       "PCI:0:2:0"
EndSection
```
