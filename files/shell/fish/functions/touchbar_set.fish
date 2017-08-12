function touchbar_set
  echo -en "\033]1337;SetKeyLabel=$argv[1]=$argv[2..-1]\a"
end
