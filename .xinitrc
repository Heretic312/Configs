#!/bin/sh

#Enable uim at startup
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
#export GTK_IM_MODULE=uim
#export XMODIFIERS="@im=uim"
#export LANG=ja_JP.UTF-8 LANGUAGE=ja_JP.UTF-8 LC_MESSAGES=ja_JP.UTF-8

#Enable Japanese uim module
#uim-xim --engine=anthy &

#Set Wallpaper
feh --bg-scale ~/Pictures/Black.jpg &

#Set Keyboard Layout
setxkbmap de &

#Removing the ugly x cursor
xsetroot -cursor_name left_ptr
 
#numlockx &
#exec mpd &
#exec conky &

#WindowManagers/Environments
exec fluxbox
 
# dwm
#while true
#do
#   xsetroot -name "`date` `uptime | sed 's/.*,//'`"
#   sleep 1
#done &
#exec dwm

#exec pekwm

#exec ratpoison

#exec hackedbox

#exec larswm

#vdesk &

#exec twm

#exec ctwm

#exec evilwm -fg "#88aa22" -bg "#ea6868" -bw 2 -term gmrun

#exec evilwm -fg "#262729" -bg "#262729" -bw 2 -term gmrun

#exec /usr/local/bin/cwm

#exec fvwm
