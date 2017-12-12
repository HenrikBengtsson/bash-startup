#!/usr/bin/env bash
. tests/init/load.sh

## Help
echo "source_d ..."

export STARTUP_DEBUG=0
source_d examples/.bashrc.d/

export STARTUP_DEBUG=1
source_d examples/.bashrc.d/

export STARTUP_DEBUG=2
source_d examples/.bashrc.d/

export STARTUP_DEBUG=0
source_d examples/.bashrc.d/ examples/.bashrc.d/

## Assert that dryrun does not output anything to standard output
export STARTUP_DRYRUN=true
res=$(source_d examples/.bashrc.d/)
[[ -z $res ]] && exit 1

export STARTUP_DEBUG=true
res=$(source_d examples/.bashrc.d/)
[[ -z $res ]] && exit 1

## Assert that non-dryrun outputs something to standard output
export STARTUP_DRYRUN=
export STARTUP_DEBUG=
res=$(source_d examples/.bashrc.d/)
[[ -n $res ]] && exit 1

echo "source_d ... done"

echo "TEST STATUS: OK"
