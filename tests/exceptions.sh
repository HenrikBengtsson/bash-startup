#!/usr/bin/env bash

## Calling as executable instead of source:ing

echo "./bash-startup ..."

./bash-startup
value=$?
echo "Exit code: $value"
[[ $value -eq 0 ]] && exit 1

res=$( { ./bash-startup ; } 2>&1 )
value=$?
echo "Results: $res"
echo "Exit code: $value"
[[ $value -eq 0 ]] && exit 1

echo "./bash-startup ... done"

echo "TEST STATUS: OK"
