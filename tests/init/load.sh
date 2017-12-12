#! /bin/env bash

## Stop on error and trace errors
if [[ $arg_error != false ]]; then
    set -o errexit
fi
arg_error=

if [[ $arg_trap != false ]]; then
    set -o errtrace
    trap '>&2 echo "TEST ERROR: $0 (exit code $?)"; exit $?' ERR
fi
arg_trap=

. bash-startup

debug=false
export STARTUP_DEBUG=
export STARTUP_DRYRUN=

function error() {
    >&2 echo "ERROR: $*"
    exit 1
}

function expect() {
    local args1=()
    local args2=()
    local test=
    local state=1
    while [[ $# -gt 0 ]]; do
	if [[ $1 =~ ^%[a-z]+%$ ]]; then
	    test=${1//%/}
	    state=2
	elif [[ $state -eq 1 ]]; then
	    args1+=("$1")
	elif [[ $state -eq 2 ]]; then
	    args2+=("$1")
	fi
	shift
    done
 
    local prefix="expect_$test('${args1[*]}', '${args2[*]}')"

    if $debug; then
        echo "$prefix ..."
        echo "args1: (n=${#args1[@]})"
        for tt in "${args1[@]}"; do echo "- '$tt'"; done
        echo "args2: (n=${#args2[@]})"
        for tt in "${args2[@]}"; do echo "- '$tt'"; done
    fi
    
    if [[ $test = equal ]]; then
	if [[ ${#args1[@]} -ne ${#args2[@]} ]]; then
	    error "$prefix: different lengths (${#args1[@]} != ${#args2[@]})"
	elif [[ ${args1[*]} != "${args2[*]}" ]]; then
	    error "$prefix: strings differ"
	fi
    elif [[ $test = empty ]]; then
	if [[ ${#args1[@]} -ne 0 ]]; then
	    error "$prefix: should be empty"
	fi
    elif [[ $test = nonempty ]]; then
	if [[ ${#args1[@]} -eq 0 ]]; then
	    error "$prefix: should not be empty"
	fi
    else
	error "$prefix: Unknown asserting operator: '$test'"
    fi
    
    if $debug; then
        echo "$prefix ... done"
    fi
}
