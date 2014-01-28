function glog
	switch $argv
    case oneline ol
      git log --pretty=oneline --graph --abbrev-commit
    case raw r
      git log --pretty=raw --graph
    case full f
      git log --pretty=full --graph
    case medium med m
      git log --pretty=medium --graph
    case '*'
      echo "Usage glog [ol|raw|f|m]"
  end
end
