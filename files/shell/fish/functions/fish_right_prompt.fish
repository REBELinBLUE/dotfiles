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

    echo -n ' '
    date $theme_date_format
end

function fish_right_prompt -d 'The right prompt'
    set_color $fish_color_autosuggestion

    #__cmd_duration
    __timestamp
    set_color normal
end
