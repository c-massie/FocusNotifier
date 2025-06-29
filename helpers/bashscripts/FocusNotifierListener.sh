#!/bin/bash

VARDIR="/tmp/FocusNotifier";

while read -r line; do
    if [[ ! "$line" == "§"* ]]; then
        continue;
    fi

    value="$(echo "$line" | grep -o ": .*" | cut -c3-)";
    mkdir -p "$VARDIR";

    case "$line" in
        §pid*)
            echo "$value" > "$VARDIR/pid.txt";
            pname="$(ps -p "$value" -o comm=)";
            echo "$pname" > "$VARDIR/pname.txt";

            echo "$pname";
            echo "pid: $value";
            echo "pname: $pname";
        ;;

        §wname*)
            echo "$value" > "$VARDIR/wname.txt";
            echo "name: $value";
        ;;

        §wclass*)
            echo "$value" > "$VARDIR/wclass.txt";
            echo "class: $value";
        ;;

        §wcaption*)
            echo "$value" > "$VARDIR/wcaption.txt";
            echo "caption: $value";
        ;;

        §end)
            configdir="$HOME/.config/FocusNotifier"
            listfile="$configdir/listeners.txt"

            if [ -f $listfile ]; then
                for listener in $(cat "$listfile")
                do
                    echo "Calling listener: $listener"
                    bash "$listener"
                done
            fi
        ;;
    esac
done < <(dbus-monitor "destination=scot.massie.FocusNotifier,path=/scot/massie/FocusNotifier,interface=scot.massie.FocusNotifier")
