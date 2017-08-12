function touchbar_pop
  if [ "$argv" = "" ]
    echo -en "\033]1337;PopKeyLabels\a"
  else
    echo -en "\033]1337;PopKeyLabels=$argv\a"
  end
end
