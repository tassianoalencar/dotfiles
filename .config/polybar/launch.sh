#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# polybar main 2>&1 | tee -a /tmp/polybar1.log & disown
polybar topbar 2>&1 | tee -a /tmp/polybar-topbar.log & disown

