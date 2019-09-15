#!/usr/bin/bash

USAGE="Usage: $(basename $0) <OPTIONS>

Options:
    -s <value>   Set specific percentage <value>
    -i <value>   Increase the current value by <value> percentage
    -d <value>   Decrease the current value by <value> percentage
    -l           List all backlight backend available
    -b <backend> Set the specific backlight backend to use
    -h           Print this help message"

backlight_dir="/sys/class/backlight"

function list_bl_sys {
	if [ ! -d $backlight_dir ]; then
		echo "BUG: $backlight_dir does not exist"
		exit 1
	fi

	for bl_hw in $backlight_dir/*; do
		echo $(basename $bl_hw)
	done
}

while [ ! -z "$1" ]; do
	case $1 in
		-h)
			echo "$USAGE"
			exit 0
			;;
		-l)
			list_bl_sys
			exit 0
			;;
		-b)
			bl_sys="$2"
			shift
			;;
		-i)
			if [ -n "$decrease" ]; then
				echo "-s, -i and -d can't be used together"
				exit 1
			fi
			increase="$2"
			shift
			;;
		-d)
			if [ -n "$increase" ]; then
				echo "-s, -i and -d can't be used together"
				exit 1
			fi
			decrease="$2"
			shift
			;;
		-s)
			if [ -n "$increase" -o -n "$decrease" ]; then
				echo "-s, -i and -d can't be used together"
				exit 1
			fi
			set_bright="$2"
			shift
			;;
		*)
			echo "$USAGE"
			exit 1
			;;
	esac
	shift
done

if [ "$EUID" -ne 0 ]; then
	echo "ERROR: you must be root"
	exit 1
fi

if [ ! -d $backlight_dir ]; then
	echo "BUG: $backlight_dir does not exist"
	exit 1
fi

if [ -z "$bl_sys" ]; then
	bl_available=""

	for bl_hw in $backlight_dir/*; do
		bl_available+="$(basename $bl_hw) "
	done

	if [ "$(echo "$bl_available" | wc -w)" -gt 1 ]; then
		echo "please choose one of the backlight system available to use with -b option"
		echo "$bl_available"
	else
		bl_sys=$(echo $bl_available | xargs)
	fi
fi

if [ ! -d "$backlight_dir/$bl_sys" ]; then
	echo "BUG: '$backlight_dir/$bl_sys' isn't a valid path"
	exit 1
fi

max_brightness=$(cat $backlight_dir/$bl_sys/max_brightness 2> /dev/null)
if [ -z "$max_brightness" ]; then
	echo "BUG: 'max_brightness' isn't a valid file"
	exit 1
fi

perc=$((max_brightness / 100))
perc=${perc%.*}

curr="$(cat $backlight_dir/$bl_sys/brightness 2> /dev/null)"
if [ -z "$curr" ]; then
	echo "BUG: 'brightness' isn't a valid file"
	exit 1
fi

if [ -n "$increase" ]; then
	if [ $((curr + increase * perc)) -ge "$max_brightness" ]; then
		echo "$max_brightness" > $backlight_dir/$bl_sys/brightness
	else
		echo "$((curr + increase * perc))" > $backlight_dir/$bl_sys/brightness
	fi
elif [ -n "$decrease" ]; then
	if [ "$((curr - decrease * perc))" -le 0 ]; then
		echo "0" > $backlight_dir/$bl_sys/brightness
	else
		echo "$((curr - decrease * perc))" > $backlight_dir/$bl_sys/brightness
	fi
elif [ -n "$set_bright" ]; then
	if [ "$set_bright" -ge "100" ]; then
		echo "$max_brightness" > $backlight_dir/$bl_sys/brightness
	elif [ "$set_bright" -le "0" ]; then
		echo "0" > $backlight_dir/$bl_sys/brightness
	else
		echo "$((set_bright * perc))" > $backlight_dir/$bl_sys/brightness
	fi
fi
