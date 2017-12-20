#!/usr/bin/env bash
arg_error=false
arg_trap=false
. tests/init/load.sh

echo "Exceptions ..."

echo "- Error: calling ./bash-startup"
res=$( { ./bash-startup ; } 2>&1 )
value=$?
echo "Exit code: $value"
echo "Results: $res"
[[ $value -eq 0 ]] && exit 1


echo "- Error: startup_source_d <no-args>"
res=$( { startup_source_d ; } 2>&1 )
value=$?
echo "Exit code: $value"
echo "Results: $res"
[[ $value -eq 0 ]] && exit 1


echo "- Error: startup_source_d non-existing-folder"
res=$( { startup_source_d non-existing-folder; } 2>&1 )
value=$?
echo "Exit code: $value"
echo "Results: $res"
[[ $value -eq 0 ]] && exit 1

echo "Exceptions ... done"

echo "TEST STATUS: OK"
