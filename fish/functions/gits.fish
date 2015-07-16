# Quick and dirty way of seeing what the status of many git repos is

function gits
  for dir in (ls -d */)
    cd $dir
    if test -d .git
      echo ======
      echo $dir
      git status
      echo
    end
    cd ..
  end
end
