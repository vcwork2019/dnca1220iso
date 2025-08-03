
#!/bin/bash

# function: install EPEL
install_epel() {
    echo "---"
    echo "Installing Extra Packages for Enterprise Linux (EPEL)..."
    sudo dnf install -y epel-release
    if [ $? -eq 0 ]; then
        echo "Done!"
    else
        echo "Failed! Check error message."
    fi
    echo "---"
}

# function: install Fish shell
install_fish_shell() {
    echo "---"
    echo "Installing Fish shell..."
    sudo dnf install -y fish util-linux-user
    # set fish as default shell (reboot to activate)
    chsh -s /usr/bin/fish
    if [ $? -eq 0 ]; then
        echo "Done!"
        # init fish to generate config.fish
        echo "***********************************************"
        echo "Type 'exit' manually to go back to installer!!!"
        echo "***********************************************"
        fish
    else
        echo "Failed! Check error message."
    fi
    echo "---"
}

# function: install Fish extensions (Fisher and Starship)
install_fish_extensions() {
    echo "---"
    echo "Installing Fish extensions..."

    # Install Fisher
    echo "Installing Fisher..."
    curl -sL https://git.io/fisher | fish
    if [ $? -eq 0 ]; then
        echo "Done!"
    else
        echo "Failed! Check error message."
    fi

    # Install Starship
    echo "Installing Starship..."
    dnf install -y tar
    curl -sS https://starship.rs/install.sh | sh
    if [ $? -eq 0 ]; then
        echo "Done!"
    else
        echo "Failed! Check error message."
    fi
    echo "---"
}

# function: customize Fish theme
customize_fish_theme() {
    echo "---"
    echo "Customize Fish theme..."
    echo "Listing Fish theme :"
    fish -c "fish_config theme list"
    read -p "Enter your choice (e.g. ayu Dark): " theme_name

    if [ -n "$theme_name" ]; then
        echo "Saving Fish theme as '$theme_name'..."
        fish -c "fish_config theme choose '$theme_name'"
        fish -c "fish_config theme save '$theme_name'"
        if [ $? -eq 0 ]; then
            echo "Done!"
        else
            echo "Failed! Check the theme_name you typed."
        fi
    else
        echo "Input value:null. Nothing to do."
    fi
    echo "---"
}

# function: customize starship prompt symbol
customize_starship_symbol() {
    echo "---"
    echo "Customizing prompt symbol..."
    cat <<EOF >> /root/.config/starship.toml
    [character]
    success_symbol="[>> ](bold yellow)"
    error_symbol="[<< ](bold red)"
EOF
    if [ $? -eq 0 ]; then
        echo "Done!"
    else
        echo "Failed! Check error message."
    fi
    echo "---"
}

# function: import CKC aliases
import_CKC_aliases() {
    echo "---"
    echo "Importing CKC aliases..."
    # CKC customize config.fish
    # clean original content in config.fish
    truncate -s 0 /root/.config/fish/config.fish
    # write customized content to config.fish
    cat << EOF >> /root/.config/fish/config.fish
    function fish_greeting
        echo Current Time: (set_color yellow)(date +%T)(set_color normal)
        curl -4 ifconfig.co
        hostname -I
        hostname -A
        dncaon
        echo
        echo (set_color green)---Discover Network Capture Status---(set_color normal)
        dncaps
    end
    if status is-interactive
    # Commands to run in interactive sessions can go here
    # for starship
    starship init fish | source
    #Custom Aliases
    alias dncaps='cd /usr/local/dncauser/bin && ./discover ps && cd ~'
    alias dncago='cd /usr/local/dncauser/bin && ./discover start all && cd ~'
    alias dncaon='cd /usr/local/dncauser/bin && ./discover start all && cd ~'
    alias dncaup='cd /usr/local/dncauser/bin && ./discover start all && cd ~'
    alias dncastop='cd /usr/local/dncauser/bin && ./discover stop all && cd ~'
    alias dncaoff='cd /usr/local/dncauser/bin && ./discover stop all && cd ~'
    alias dncadown='cd /usr/local/dncauser/bin && ./discover stop all && cd ~'
    alias restarthttpd='cd /usr/local/dncauser/bin && ./discover stop httpd && ./discover start httpd && cd ~'
    alias httpdrestart='cd /usr/local/dncauser/bin && ./discover stop httpd && ./discover start httpd && cd ~'
    alias 881='systemctl reboot'
    alias 886='systemctl poweroff'
    alias editalias='vim /root/.config/fish/config.fish'
    alias refreshalias='source /root/.config/fish/config.fish'
    alias updatealias='source /root/.config/fish/config.fish'
    end
EOF
    if [ $? -eq 0 ]; then
        echo "Done!"
    else
        echo "Failed! Check error message."
    fi
    echo "---"
}

# function: install extra tools (bat, mkisofs, ranger, tldr, tmux)
install_extra_tools() {
    echo "---"
    echo "Installing Extra tools (bat, mkisofs, ranger, tldr, tmux) ..."
    sudo dnf install -y bat mkisofs ranger tldr tmux net-tools
    if [ $? -eq 0 ]; then
        echo "Done!"
    else
        echo "Failed! Check error message."
    fi
    echo "---"
}

# Menu
while true; do
    echo ""
    echo "--- Better Text-Mode for AlmaLinux9 Installer by CKC ---"
    echo ""
    echo "1) Extra Packages for Enterprise Linux (EPEL)"
    echo "2) Install Fish shell"
    echo "3) Install Fish extension (Fisher, Starship)"
    echo "4) Customize Fish Theme"
    echo "5) Customize prompt symbol"
    echo "6) Import CKC Aliases"
    echo "7) Install Extra tools"
    echo "8) Exit"
    echo ""
    read -p "Your choice (1-8): " choice

    case $choice in
        1)
            install_epel
            ;;
        2)
            install_fish_shell
            ;;
        3)
            install_fish_extensions
            ;;
        4)
            customize_fish_theme
            ;;
        5)
            customize_starship_symbol
            ;;
        6)
            import_CKC_aliases
            ;;
        7)
            install_extra_tools
            ;;
        8)
            echo ""
            echo "Check imported aliases with 'alias'."
            echo "Path to fish function : /root/.config/fish/functions/"
            echo "--- for extra tools ---"
            echo "bat : enhance cat command"
            echo "ranger : a TUI file manager."
            echo "tldr : a simplified command guide."
            echo "tmux : a terminal multiplexer."
            echo "mkisofs : to create ISO files."
            exit 0
            ;;
        *)
            echo "Invalid input."
            ;;
    esac
done
