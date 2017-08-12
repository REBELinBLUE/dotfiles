function touchbar_push
  if [ "$argv" = "" ]
    echo -en "\033]1337;PushKeyLabels\a"
  else
    echo -en "\033]1337;PushKeyLabels=$argv\a"
  end
end
