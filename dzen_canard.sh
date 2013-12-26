#!/bin/bash
#  "THE BEER-WARE LICENSE" (Revision 42):
#  <nicolas.appriou@gmail.com> wrote this file. As long as you retain this
#  notice you can do whatever you want with this stuff. If we meet
#  some day, and you think this stuff is worth it, you can buy me
#  a beer in return

share_dir=/usr/local/share/dzen-canard
lib_dir=/usr/local/lib/dzen-canard
cfg_dir=/usr/local/etc
user_cfg_dir=$HOME/.config/dzen-canard
canard_dir_NOT_INSTALLED=`dirname $0` # removed if installed


USER_CFG=(
  $cfg_dir/dzen-canard
  $user_cfg_dir/config.sh
  $canard_dir_NOT_INSTALLED/config.sh
)

CANARD_LIB=(
  $lib_dir
  $HOME/.config/dzen-canard/lib/
  $canard_dir_NOT_INSTALLED/canard-lib/
)

ICON_PATHS=(
  $canard_dir_NOT_INSTALLED/icons/
  $user_cfg_dir/icons/
  $share_dir/icons/
)

CANARD_EXEC=$canard_dir_NOT_INSTALLED/example.sh # changed if installed


# get_icon icon_name
# get icon path, taking care of user define icons
function get_icon {
  icon_filename=$1

  for icon_path in ${ICON_PATHS[*]};do
    if [ -f $icon_path/$icon_filename ];then
      echo $icon_path/$icon_filename 
      break
    fi
  done
}


# get_fg_color [color]
# Build a foreground color dzen argument
# if no argument, set default colors
function get_fg_color {
  if [ -z "$1" ];then
    fg=FG
  else
    fg=$1
  fi

  echo "^fg(${!fg})"
}

# get_bg_color [color]
# Build a background color dzen argument
# if no argument, set default colors
function get_bg_color {
  if [ -z "$1" ];then
    bg=BG
  else
    bg=$1
  fi

  echo "^bg(${!bg})"
}

# get_color [bg color fg color]
# Build a background and foreground color dzen argument
# if no argument, set default colors
function get_color {
  echo $(get_bg_color $1)$(get_bg_color $2)
}

# set_fg_color color str
# embed a string with foreground color, and set default one after
function set_fg_color {
  echo "^fg(${!1})$2^fg($FG)"
}

# set_bg_color color str
# embed a string with background color, and set default one after
function set_bg_color {
  echo "^bg(${1!})$2^bg{$BG}"
}

# set_color bg fg str
# embed a string with background and foreground color, and set
# default one after
function set_color {
  echo $(set_bg_color $1 $(set_fg_color $2 $3))
}

# default formatter. A formatter takes all data string that will be printed
# on the dzen bar and formats them for better reading. In this case, it will
# be something like [   <data>   |   <data>   ]
function build_string {
  str=$BEGIN
  prev_separator=

  for el in $@;do
    str=$str$prev_separator$($el)
    prev_separator=$SEPARATOR
  done

  echo "$(get_color)$str$END"
}


# build dzen argument to set default background and foreground colors.
function get_cli_color {
  echo "-bg $BG -fg $FG"
}

# build dzen default arguments according to dzen canard config files
function build_dzen2_args {
  [ -n "$FONT" ] && font="-fn $FONT"
  [ -n "$WIN_HEIGHT" ] && win_height="-h $WIN_HEIGHT"
  [ -n "$WIN_WIDTH" ] && win_height="-w $WIN_WIDTH"
  [ -n "$X_SCREEN" ] && xscreen="-xs $X_SCREEN"

  echo $(get_cli_color) $font $win_height $win_width $xscreen 
}

# must define a SLEEP variable to indicate how many time to sleep between
# each loop
# arguments to this functin are function to be processed at each loop
# --args to append to dzen 2
# --formatter can be provided to override default formatter
# --sleep to override the default sleep time (define in configuration)
function run_loop {
  content=()
  formatter=build_string
  sleep=$SLEEP

  while [ "$#" -gt "0" ];do
    case "$1" in
      -a|--args)
        dz_args=$2
        shift 2
        ;;
      -f|--formatter)
        formatter=$2
        shift 2
        ;;
      -s|--sleep)
        sleep=$2
        shift 2
        ;;
      *)
        content[${#content[*]}]=$1
        shift 1
        ;;
    esac
  done

  while :;do
    $formatter ${content[@]}
    sleep $sleep
  done | dzen2 $(build_dzen2_args) $dz_args
}

# the config file uses some of the previously defined function. We need
# to source config file once they are defined.
for cfg_file in ${USER_CFG[*]};do
  [ -f $cfg_file ] && source $cfg_file
done


# source the libs
for lib_dir in ${CANARD_LIB[*]};do
  [ -d $lib_dir ] || continue
  for lib_file in $(ls $lib_dir/dzen_*);do
    [ -f $lib_file ] && source $lib_file
  done
done

# run user defined canard
source $CANARD_EXEC
