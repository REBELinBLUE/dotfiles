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
  set -l ___vagrant_running_glyph   '↑'
  set -l ___vagrant_poweroff_glyph  '↓'
  set -l ___vagrant_aborted_glyph   '✖'
  set -l ___vagrant_saved_glyph     '⇡'
  set -l ___vagrant_stopping_glyph  '⇣'
  set -l ___vagrant_unknown_glyph   '!'

  set -l vagrant_status
  for id in (__vagrant_ids)
    set -l vm_status (VBoxManage showvminfo --machinereadable $id ^/dev/null | command grep 'VMState=' | tr -d '"' | cut -d '=' -f 2)
    switch "$vm_status"
      case 'running'
        set vagrant_status "$vagrant_status$___vagrant_running_glyph"
      case 'poweroff'
        set vagrant_status "$vagrant_status$___vagrant_poweroff_glyph"
      case 'aborted'
        set vagrant_status "$vagrant_status$___vagrant_aborted_glyph"
      case 'saved'
        set vagrant_status "$vagrant_status$___vagrant_saved_glyph"
      case 'stopping'
        set vagrant_status "$vagrant_status$___vagrant_stopping_glyph"
      case ''
        set vagrant_status "$vagrant_status$___vagrant_unknown_glyph"
    end
  end
  [ -z "$vagrant_status" ]; and return

  set_color yellow
  echo -ns $vagrant_status ' '
  set_color normal
end


function __docker -S -d 'Show docker machine name'
    [ -z "$DOCKER_MACHINE_NAME" ]; and return

    set_color green
    echo -ns $DOCKER_MACHINE_NAME ' '
    set_color normal
end


function fish_right_prompt -d 'The right prompt'
    set_color normal

    #__cmd_duration
    #__docker
    __vagrant
    __timestamp

    set_color normal
end
