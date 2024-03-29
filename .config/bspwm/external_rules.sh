#!/bin/bash
# taken from
# https://github.com/ghomasHudson/bspwm-dwm.githttps://github.com/ghomasHudson/bspwm-dwm.git

bspc query -N -n .leaf.local.\!automatic >/dev/null && exit
master_area="${BSPWMMASTER:-west}" west="@/1" east="@/2" north="$west" south="$east"
case "$master_area" in
    west|east) ss_dir="south";;&
    west) stack_area="east";;
    east) stack_area="west";;
    north|south) ss_dir="east";;&
    north) stack_area="south";;
    south) stack_area="north";;
esac
localnodect="$(bspc query -N -n .leaf.local | wc -l)"
if [ $localnodect -gt 1 ]; then
    echo "node=${!stack_area} split_dir=${ss_dir}"
else
    echo "private=on split_dir=${stack_area}"
fi
