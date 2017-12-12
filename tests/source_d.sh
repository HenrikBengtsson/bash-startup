#!/usr/bin/env bash
. tests/init/load.sh

## Help
echo "source_d ..."

folders="examples/.bashrc.d/"
for debug in 2 1 0; do
  printf "* source_d with STARTUP_DEBUG=$debug ... "
  export STARTUP_DEBUG=$debug
  stdout=$(source_d $folders 2> /dev/null)
  stderr=$( { source_d $folders > /dev/null; } 2>&1 )
  [[ -z $stdout ]] &&  error "stdout is empty"
  [[ $debug -eq 0 ]] && [[ -n $stderr ]] && error "stderr is non-empty: '$stderr"
  [[ $debug -ne 0 ]] && [[ -z $stderr ]] && error "stderr is empty"
  echo "done"
done

printf "* source_d with multiple folders ... "
folders="examples/.bashrc.d/ examples/.bashrc.d/"
stdout=$(source_d $folders 2> /dev/null)
stderr=$( { source_d $folders > /dev/null; } 2>&1 )
[[ -z $stdout ]] &&  error "stdout is empty"
[[ -n $stderr ]] && error "stderr is non-empty: '$stderr'"
echo "done"

printf "* source_d - dryryn ... "
export STARTUP_DEBUG=
export STARTUP_DRYRUN=true
folders="examples/.bashrc.d/"

stdout=$(source_d $folders 2> /dev/null)
stderr=$( { source_d $folders > /dev/null; } 2>&1 )
[[ -n $stdout ]] && error "stdout is non-empty: '$(printf "%s\n" $stdout)'"
[[ -z $stderr ]] && error "stderr is empty"

export STARTUP_DEBUG=true
stdout=$(source_d $folders 2> /dev/null)
stderr=$( { source_d $folders > /dev/null; } 2>&1 )
[[ -n $stdout ]] && error "stdout is non-empty: '$(printf "%s\n" $stderr)'"
[[ -z $stderr ]] && error "stderr is empty"
export STARTUP_DRYRUN=
export STARTUP_DEBUG=
echo "done"

echo "source_d ... done"

echo "TEST STATUS: OK"
