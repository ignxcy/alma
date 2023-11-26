#!/bin/sh

## colors

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 25)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
RESET=$(tput sgr0)

## get the os 

os=$(sed -nE "s@PRETTY_NAME=\"([^\"]*)\"@\1@p" /etc/os-release)

## get the kernel

kernel=$(uname -s -r)

## get the uptime 

uptime=$(uptime | sed -E 's/^[^,]*up *//; s/mins/minutes/; s/hrs?/hours/;
  s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/;
  s/^1 hours/1 hour/; s/ 1 hours/ 1 hour/;
  s/min,/minutes,/; s/ 0 minutes,/ less than a minute,/; s/ 1 minutes/ 1 minute/;
  s/  / /; s/, *[[:digit:]]* users?.*//')

## get the de/wm and the display server

dewmds="$(echo $XDG_CURRENT_DESKTOP) ($(echo $XDG_SESSION_TYPE))"

## get the used/available ram

ram=$(free | grep Mem | awk '{printf "%.1f MiB / %.1f MiB", $3/1024, $2/1024}')

## get the CPU 
CPU=$(lscpu | grep "Model name" | sed 's/Model name:\s*//')

## get GPU
GPU=$(lspci | grep "VGA compatible controller" | sed 's/.*: //')

echo -n "$BLUE      /\    $BLUE    OS: $RESET     $os" 
echo 
echo -n "$BLUE     /  \   $BLUE    Kernel: $RESET $kernel"
echo 
echo -n "$BLUE    /\   \  $BLUE    Uptime: $RESET $uptime"
echo
echo -n "   /      \   $BLUE  DE/WM:  $RESET $dewmds"
echo 
echo -n "  /   ,,   \  $BLUE  Ram:    $RESET $ram"
echo
echo -n " /   |  |  -\ $BLUE  CPU:    $RESET $CPU"
echo 
echo -n "/_-''    ''-_\ $BLUE GPU:    $RESET $GPU"
echo 
