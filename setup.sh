#!/bin/bash

bin_dir=/usr/local/bin
lib_dir=/usr/local/lib/dzen-canard
share_dir=/usr/local/share/dzen-canard
cfg_dir=/usr/local/etc

canard_bin=$bin_dir/dzen-canard
canard_cfg=$cfg_dir/dzen-canard

if [ "$1" = 'uninstall' ];then
  rm -f $canard_bin
  rm -f $canard_cfg
  rm -rf $lib_dir
  rm -rf $share_dir
else
  # ensure directories existence
  [ ! -d "$bin_dir" ] && mkdir $bin_dir -p
  [ ! -d "$cfg_dir" ] && mkdir $cfg_dir -p
  [ ! -d "$lib_dir" ] && mkdir $lib_dir -p
  [ ! -d "$share_dir" ] && mkdir $share_dir -p

  # bin
  # remove local path
  sed 's/^CANARD_EXEC.*/CANARD_EXEC=$HOME\/.config\/dzen-canard\/canard.sh/' dzen_canard.sh | \
    sed '/NOT_INSTALLED/d'  > $canard_bin
  chown root:root $canard_bin
  chmod 755 $canard_bin

  # config file
  cp config.sh $canard_cfg
  chown root:root $canard_cfg
  chmod 644 $canard_cfg

  # libs
  cp canard-lib/dzen_*.sh $lib_dir/.
  chown root:root $lib_dir/dzen_*.sh
  chmod 644 $lib_dir/dzen_*.sh

  # icons
  cp -r icons $share_dir/.
  chown -R root:root $share_dir/*
  chmod 644 $share_dir/icons/*
fi
