function fish_prompt
    # Get current user
    set -l user (whoami)

    # Get hostname
    set -l host (string split '.' $hostname)[1]

    # Get current directory (use ~ for home)
    set -l pwd (prompt_pwd)

    # Build the prompt with colors
    echo -n (set_color fb4934)"["
    echo -n (set_color fabd2f)$user
    echo -n (set_color b8bb26)"@"
    echo -n (set_color 83a598)$hostname
    echo -n (set_color d3869b)" "
    echo -n (set_color d3869b)$pwd
    echo -n (set_color fb4934)"]"
    echo -n (set_color white)"\$ "

    # Reset color
    set_color normal
end
