#!/usr/bin/env bash
. tests/init/load.sh

## Help
echo "startup_source ..."

file="examples/.bashrc.d/hello.sh"
for debug in 2 1 0; do
  printf "* startup_source with STARTUP_DEBUG=%s ... " $debug
  export STARTUP_DEBUG=$debug
  stdout=$(startup_source "$file" 2> /dev/null)
  stderr=$( { startup_source "$file" > /dev/null; } 2>&1 )
  [[ -z $stdout ]] &&  error "stdout is empty"
  [[ $debug -eq 0 ]] && [[ -n $stderr ]] && error "stderr is non-empty: '$file"
  [[ $debug -ne 0 ]] && [[ -z $stderr ]] && error "stderr is empty"
  echo "done"
done

printf "* startup_source - dryryn ... "
export STARTUP_DEBUG=
export STARTUP_DRYRUN=true

stdout=$(startup_source "$file" 2> /dev/null)
stderr=$( { startup_source "$file" > /dev/null; } 2>&1 )
[[ -n $stdout ]] && error "stdout is non-empty: '$(printf "%s\\n" "$stdout")'"
[[ -z $stderr ]] && error "stderr is empty"

export STARTUP_DEBUG=true
stdout=$(startup_source "$file" 2> /dev/null)
stderr=$( { startup_source "$file" > /dev/null; } 2>&1 )
[[ -n $stdout ]] && error "stdout is non-empty: '$(printf "%s\\n" "$stderr")'"
[[ -z $stderr ]] && error "stderr is empty"
export STARTUP_DRYRUN=
export STARTUP_DEBUG=
echo "done"

echo "startup_source ... done"

echo "TEST STATUS: OK"
