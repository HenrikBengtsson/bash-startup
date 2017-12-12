#!/usr/bin/env bash
. tests/init/load.sh

## Help
echo "bash-startup --help ..."
#. bash-startup --help
res=$(. bash-startup --help)
echo $?
[[ -z $res ]] && exit 1
echo "bash-startup --help ... done"

## Version
echo "bash-startup --version ..."
. bash-startup --version
res=$(. bash-startup --version)
echo "Version: $res"
[[ -z $res ]] && exit 1
echo "bash-startup --version ... done"

echo "TEST STATUS: OK"
