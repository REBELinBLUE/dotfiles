function itunes -d "Control iTunes. Use -h or --help for a more detailed description."
    if [ (count $argv) -gt 0 ]
        set -l opt $argv[1]
        switch $opt
            case status
                set state (osascript -e 'tell application "iTunes" to player state as string')
                echo -n "iTunes is currently "
                set_color green

                if [ $state = "paused" ]
                    set_color yellow
                else if [ $state = "stopped" ]
                    set_color red
                end

                echo "$state"
                set_color normal

                if [ $state = "playing" ]
                    set artist (osascript -e 'tell application "iTunes" to artist of current track as string')
                    set track (osascript -e 'tell application "iTunes" to name of current track as string')
                    echo -n "Current track "
                    set_color yellow
                    echo -n $artist
                    set_color normal
                    echo -n " - "
                    set_color yellow
                    echo "$track"
                    set_color normal
                end

                return 0
            case resume
                set opt "play"
            case launch play pause stop quit
            #case shuffle
            #    set opt "set shuffle of current playlist to 1"
            #case order
            #    set opt "set shuffle of current playlist to 0"
            case mute
                set opt "set mute to true"
            case unmute
                set opt "set mute to false"
            case next previous
                set opt "$opt track"
            case prev
                set opt "previous track"
            case vol volume
                set vol (osascript -e 'tell application "iTunes" to sound volume as integer')
                set newvol 100

                if [ $argv[2] = "up" ]
                    set newvol (math "$vol+10")
                else if [ $argv[2] = "down" ]
                    set newvol (math "$vol-10")
                else
                    set newvol $argv[2]
                end

                set opt "set sound volume to $newvol"
            case "" help -h --help -help
                __show_help
                return 0
            case '*'
                e_error "Unknown option '$opt'. Use -h or --help for a more detailed description."
                return 1
        end
        osascript -e "tell application \"iTunes\" to $opt"
    else
        e_error "No arguments given. Use -h or --help for a more detailed description."
    end
end


function __show_help
    echo 'Usage: itunes <option>'
    echo ''
    e_tabbed 'launch' 'Launch iTunes'
    e_tabbed 'quit' 'Quit iTunes'
    e_tabbed 'status' 'Show the current status'
    e_tabbed 'play' 'Start playback'
    e_tabbed 'pause' 'Pause playback'
    e_tabbed 'stop' 'Stop playback'
    #e_tabbed 'shuffle' 'Shuffle playback'
    #e_tabbed 'order' 'Playback in order'
    e_tabbed 'mute' 'Mute the volume'
    e_tabbed 'unmute' 'Umute the volume'
    e_tabbed 'next' 'Play the next track'
    e_tabbed 'previous' 'Play the previous track'
    e_tabbed 'vol <volume>' 'Set the volume, takes an argument from 0 to 100'
    e_tabbed 'vol up' 'Increases the volume'
    e_tabbed 'vol down' 'Decreases the volume'
    e_tabbed 'help' 'Show this message and exit'

    return 0
end
