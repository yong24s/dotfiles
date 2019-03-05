#!/bin/sh

battery_print() {
    path_ac="/sys/class/power_supply/AC"
    path_battery_0="/sys/class/power_supply/BAT0"
    path_battery_1="/sys/class/power_supply/BAT1"

    ac=0
    battery_level_0=0
    battery_level_1=0
    battery_max_0=0
    battery_max_1=0

    if [ -f "$path_ac/online" ]; then
        ac=$(cat "$path_ac/online")
    fi

    if [ -f "$path_battery_0/energy_now" ]; then
        battery_level_0=$(cat "$path_battery_0/energy_now")
    fi

    if [ -f "$path_battery_0/energy_full" ]; then
        battery_max_0=$(cat "$path_battery_0/energy_full")
    fi

    if [ -f "$path_battery_1/energy_now" ]; then
        battery_level_1=$(cat "$path_battery_1/energy_now")
    fi

    if [ -f "$path_battery_1/energy_full" ]; then
        battery_max_1=$(cat "$path_battery_1/energy_full")
    fi

    battery_level=$(("$battery_level_0 + $battery_level_1"))
    battery_max=$(("$battery_max_0 + $battery_max_1"))

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if [ "$ac" -eq 1 ]; then
        icon=""

        if [ "$battery_percent" -gt 97 ]; then
            echo "$icon"
        else
            echo "$icon $battery_percent%"
        fi
    else
        if [ "$battery_percent" -gt 95 ]; then
	    icon="瘝"
        elif [ "$battery_percent" -gt 87 ]; then
	    icon="画"
        elif [ "$battery_percent" -gt 75 ]; then
            icon="甆"
        elif [ "$battery_percent" -gt 62 ]; then
            icon="瑱"
        elif [ "$battery_percent" -gt 50 ]; then
            icon="猪"
        elif [ "$battery_percent" -gt 37 ]; then
            icon="犯"
        elif [ "$battery_percent" -gt 25 ]; then
            icon="爵"
        elif [ "$battery_percent" -gt 12 ]; then
            icon="瞧"
        else
            icon=""
        fi

        echo "$icon $battery_percent%"
    fi
}

path_pid="/home/user/.config/polybar/battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
