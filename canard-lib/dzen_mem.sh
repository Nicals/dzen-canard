# Get system memory
function dzen_mem {
  awk_mem='/^MemTotal:/ {	memtot=$2	};
  /^MemFree:/		{	memfree=$2	};
  /^Buffers:/		{	membuff=$2	};
  /^Cached:/		{	memcach=$2	};
  /^Active:/		{	memact=$2	};
  /^SwapTotal:/	{	memsw=$2	};
  /^SwapFree:/	{	memswf=$2	};
  END {
  print int((memtot-memfree)*100/memtot) "%   Act: " int(memact*100/memtot) "%   Ca: " int(memcach*100/memtot) "%   Sw: " int ((memsw-memswf)*100/memsw) "%"
}'

  echo "$ICO_MEM $(cat /proc/meminfo | awk "$awk_mem")"
}
