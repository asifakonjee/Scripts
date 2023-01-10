#!/usr/bin/env bash

pkg="$(ls ~/.local/void-packages/srcpkgs | fzf --prompt="  Search : " --border=rounded --margin=5% --color=dark --height 100% --reverse --header="Void-src Pkgs " --info=hidden --header-first)"
DIR1=$HOME/.local/void-packages/
DIR2=$HOME/.local/void-packages/srcpkgs
CHECK="$(xbps-query -s "$pkg" | wc -l)"


if [ $pkg ]
then
    if [ "$CHECK" -eq "1" ]
    then
        notify-send "You are good to go, program already installed! have a wonderful day, gorgeous!"
        sleep 2
        exit
    else
        cd "$DIR1" || exit
        git pull

        cd "$DIR2" || exit
        if [[ -d "$pkg" ]]
        then
            cd "$DIR1" || exit
            notify-send -t 60000 "installing $pkg, Please be patient" 
            ./xbps-src pkg "$pkg" && sudo xbps-install -Sy --repository hostdir/binpkgs "$pkg" 
        else
            notify-send "Not found"
            exit
        fi
    fi
else
    exit
fi
notify-send "$pkg installed"

