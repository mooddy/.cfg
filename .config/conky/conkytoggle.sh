#!/usr/bin/env bash

# Try to get a list of PIDs for appropriate conky's
runningConkys=$(pgrep -a conky | awk '/conkyrc/{print $1}')

# if runningConkys is empty
if [[ -z "$runningConkys" ]]; then
    # start conky
    conky -q -c /home/nemi/.config/conky/conkyrc &
else #not empty
    #Kill all of the PIDs listed in $runningConkys
    echo "$runningConkys" | xargs -n 1 kill -15
fi

