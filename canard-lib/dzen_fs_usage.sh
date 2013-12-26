# filesystem usage
function dzen_fs_usage {
  echo "# $(df -h | egrep '^/dev/sd[[:lower:]][[:digit:]]+' | awk 'BEGIN{ORS=" - "} ;{print $6 ": " $5}')"
}
