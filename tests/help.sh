#!/usr/bin/env bash
## Stop on error and trace errors
set -o errexit
set -o errtrace
trap '>&2 echo "TEST ERROR: $0 (exit code $?)"; exit $?' ERR 

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
