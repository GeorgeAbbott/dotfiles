#!/bin/sh

feh --bg-scale $(shuf -n1 -e ~/bgs/*) --no-fehbg
dwmblocks &
st &
