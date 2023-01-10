#!/usr/bin/env bash

bettercd() {
    >/dev/null cd $1
    if [ -z $1 ]
    then
        while true;
        do
            selection="$(lsd -a | fzf --height 98% --reverse --info hidden --border rounded --prompt "$(pwd)/" --preview ' cd_pre="$(echo $(pwd)/$(echo {}))";
                    echo $cd_pre;
                    echo;
                    lsd -a --color=always "${cd_pre}";
                    bat --style=numbers --theme=ansi --color=always {} 2>/dev/null' --bind alt-down:preview-down,alt-up:preview-up --preview-window=right:65%)"
        if [[ -d "$selection" ]]
        then
            >/dev/null cd "$selection"
        elif [[ -f "$selection" ]]
        then
            for file in $selection;
            do
                if [[ $file == *.txt ]] || [[ $file == *.sh ]] || [[ $file == *.lua ]] || [[ $file == *.conf ]] || [[ $file == .*rc ]] || [[ $file == *rc ]] || [[ $file == autostart ]] || [[ $file == *.tex ]] || [[ $file == *.py ]]
                then
                    micro "$selection"
                elif [[ $file == *.docx ]] || [[ $file == *.odt ]]
                then
                    devour libreoffice "$selection" 2>/dev/null
                elif [[ $file == *.pdf ]]
                then
                    devour okular "$selection"
                elif [[ $file == *.jpg ]] || [[ $file == *.png ]] || [[ $file == *.xpm ]] || [[ $file == *.jpeg ]]
                then
                    devour gwenview "$selection"
                else [[ $file == *.xcf ]]
                    devour gimp "$selection"
            fi
        done
        else
            break
        fi
    done
    fi
}

bettercd
