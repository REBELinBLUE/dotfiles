function fish_title
    # Display the process
    echo $_ ' '

    # Display the PWD
    echo (pwd | sed "s:^$HOME:~:")
    #prompt_pwd
end
