# cpu load average
function dzen_cpu_load {
  echo "$ICO_CPU $(w -s | head -n1 | cut -d',' -f3- | cut -d':' -f2 | sed -e 's/^[[:space:]]*//' | sed -e 's/\([[:digit:]]\+,[[:digit:]]\+\),/\1 /g')"
}
