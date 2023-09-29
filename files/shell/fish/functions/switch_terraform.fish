function switch_terraform --on-event fish_postexec
    string match --regex '^cd\s' "$argv" > /dev/null
    set --local is_command_cd $status

    if test $is_command_cd -eq 0
      if count .terraform-version > /dev/null
        command tfswitch
      end
    end
end
