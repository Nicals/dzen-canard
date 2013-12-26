#!/bin/bash


# dzen_cpu_load, dzen_fs_usage and dzen_date are function that will add
# some content to the dzen-bar. The args argument adds argument to the
# dzen command line.
# Content to be print will be formatted using the default formatter
# 'build_string'
run_loop dzen_cpu_load dzen_fs_usage dzen_date --args '-xs 1' 


# a new formatter is defined. It takes the result of the data function
# defined on the command line and add some formatting stuff.
function formatter {
  str='> '

  for el in $@;do
    str="$str $($el) > "
  done

  echo $str
}

# here, we override the default formatter to a worse one.
run_loop dzen_date --formatter formatter --args '-xs 2' 
