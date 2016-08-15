function __cmd_duration -S -d 'Show command duration'
    [ "$CMD_DURATION" -lt 100 ]; and return

    if [ "$CMD_DURATION" -lt 5000 ]
        echo -ns $CMD_DURATION 'ms'
    else if [ "$CMD_DURATION" -lt 60000 ]
        math "scale=1;$CMD_DURATION/1000" | sed 's/\\.0$//'
        echo -n 's'
    else if [ "$CMD_DURATION" -lt 3600000 ]
        set_color $fish_color_error
        math "scale=1;$CMD_DURATION/60000" | sed 's/\\.0$//'
        echo -n 'm'
    else
        set_color $fish_color_error
        math "scale=2;$CMD_DURATION/3600000" | sed 's/\\.0$//'
        echo -n 'h'
    end

    set_color $fish_color_normal
    set_color $fish_color_autosuggestion

    echo -ns ' <'
end

function __timestamp -S -d 'Show the current timestamp'
    set -l theme_date_format "+%H:%M:%S"

    set_color cyan
    date $theme_date_format
    set_color normal
end

function __vagrant_ids -S -d 'List Vagrant machine ids'
  for file in .vagrant/machines/**/id
    read id <$file
    echo $id
  end
end

function __vagrant -S -d 'Display VirtualBox Vagrant status'
  set -l __vagrant_running_glyph   '↑'
  set -l __vagrant_poweroff_glyph  '↓'
  set -l __vagrant_aborted_glyph   '✖'
  set -l __vagrant_saved_glyph     '⇡'
  set -l __vagrant_stopping_glyph  '⇣'
  set -l __vagrant_unknown_glyph   '!'
  set -l __vagrant_seperator_glyph '·'

  set -l vagrant_ids (__vagrant_ids)

  set -l show_vm_names "no"
  if test (count $vagrant_ids) -gt 1
    set show_vm_names "yes"
  end

  set -l vagrant_status
  for id in $vagrant_ids
    # FIXME: showvminfo is duplicated, clean up.
    # FIXME: Remove common prefix, i.e. debian-
    set -l vm_status (VBoxManage showvminfo --machinereadable $id ^/dev/null | command grep 'VMState=' | tr -d '"' | cut -d '=' -f 2)

    set -l vm_name
    if [ "$show_vm_names" = "yes" ]
      set -l basename (basename (pwd))
      set vm_name (VBoxManage showvminfo --machinereadable $id ^/dev/null | command grep 'name=' | tr -d '"' | cut -d '=' -f 2 | sed -e "s/$basename\-//g")
      set vm_name "$__vagrant_seperator_glyph$vm_name"
    end

    # If the status is not empty it is not the first VM so add the seperator
    if [ ! -z "$vagrant_status" ]
      set vagrant_status "$vagrant_status "
    end

    switch "$vm_status"
      case 'running'
        set vagrant_status "$vagrant_status$__vagrant_running_glyph$vm_name"
      case 'poweroff'
        set vagrant_status "$vagrant_status$__vagrant_poweroff_glyph$vm_name"
      case 'aborted'
        set vagrant_status "$vagrant_status$__vagrant_aborted_glyph$vm_name"
      case 'saved'
        set vagrant_status "$vagrant_status$__vagrant_saved_glyph$vm_name"
      case 'stopping'
        set vagrant_status "$vagrant_status$__vagrant_stopping_glyph$vm_name"
      case ''
        set vagrant_status "$vagrant_status$__vagrant_unknown_glyph$vm_name"
    end
  end
  [ -z "$vagrant_status" ]; and return

  set_color yellow
  echo -ns $vagrant_status ' '
  set_color normal
end

function __file_count
  ls -1 | wc -l | sed 's/\ //g'
end

function __prompt_status -S -a last_status -d 'Display symbols for a non zero exit status, root and background jobs'
    set -l nonzero
    set -l superuser
    set -l bg_jobs

    # Last exit was nonzero
    [ $last_status -ne 0 ]
        and set nonzero 1

    # if superuser (uid == 0)
    [ (id -u $USER) -eq 0 ]
        and set superuser 1

    # Jobs display
    [ (jobs -l | wc -l) -gt 0 ]
        and set bg_jobs 1

    if [ "$nonzero" -o "$superuser" -o "$bg_jobs" ]
        echo -n "[ "
        if [ "$nonzero" ]
            set_color normal
            set_color red --bold

            echo -ns $last_status
            #echo -n '!'
            set_color normal
            echo -n ' '
        end

        if [ "$superuser" ]
            set_color normal
            set_color --bold yellow
            echo -n '$'s
            set_color normal
            echo -n ' '
        end

        if [ "$bg_jobs" ]
            set_color normal
            set_color --bold blue
            echo -n '%'
            set_color normal
            echo -n ' '
        end

        echo -n "] "
    end
end

function fish_right_prompt -d 'The right prompt'
    set -l last_status $status

    set_color normal

    #__cmd_duration
    __prompt_status $last_status
    __vagrant
    __timestamp

    set_color normal
end
