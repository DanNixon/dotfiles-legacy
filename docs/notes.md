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

## PGP smart card

- `apt install scdaemon pcscd pcsc-tools`
- `pcsc_scan -n`

Reader can be manually selected in `.gnupg/scdaemon.conf` using `reader-port` if
needed.

## Broadcom wireless not working on Ubuntu

See [here](https://ubuntuforums.org/showthread.php?t=2214110).

## List available fonts

`updmap-sys --listmaps`
