awk -F' ' '/START/{f="start"} {if ($1 ~ /-./){ f=$1 } print > "part"f".log"}' large.txt
