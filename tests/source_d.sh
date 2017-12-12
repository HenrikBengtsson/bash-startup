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

echo "source_d ... done"

echo "TEST STATUS: OK"
