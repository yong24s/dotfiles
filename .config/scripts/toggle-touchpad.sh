#!/bin/bash

TOUCHPAD="SynPS/2 Synaptics TouchPad"

if xinput list-props "$TOUCHPAD" | grep "Device Enabled (145):.*1" >/dev/null
then
  xinput disable "$TOUCHPAD"
  notify-send -u low -i mouse "Trackpad disabled"
else
  xinput enable "$TOUCHPAD"
  notify-send -u low -i mouse "Trackpad enabled"
fi

