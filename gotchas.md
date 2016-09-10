# Gotchas

A few issues I've had to resolve during setup that I'd probably forget how to
do.

## Setting Fish PATH

```
set --universal fish_user_paths $fish_user_paths ~/path/name
```

https://github.com/fish-shell/fish-shell/issues/527#issuecomment-32237807

## No toolbar in OpenSCAD

Remove the `appmenu-qt5` package.

https://bugs.launchpad.net/ubuntu/+source/appmenu-qt5/+bug/1307619
