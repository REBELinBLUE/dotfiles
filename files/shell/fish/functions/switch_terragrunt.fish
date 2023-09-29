function switch_terragrunt --on-event fish_postexec
    string match --regex '^cd\s' "$argv" > /dev/null
    set --local is_command_cd $status

    if test $is_command_cd -eq 0
      if count .terragrunt-version > /dev/null
        command tgswitch
      end
    end
end
