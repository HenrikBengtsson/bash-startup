#!/usr/bin/env bash
. tests/init/load.sh

## Load functions
declare -a files=(
    a=11/b/c.sh
    a/b=11/c.sh
    a/b/c=11.sh
    
    a!=11/b/c.sh
    a/b!=11/c.sh
    a/b/c!=11.sh

    a/b/c
)

echo "Files (n=${#files}):"
printf "* '%s'\n" ${files[@]}
expect "${files[@]}" %nonempty%


printf "Filter (nonexisting): "
files2=($(startup_filter_by_envvar EQUAL nonexisting ${files[@]}))
expect ${files2[@]} %nonempty%
expect ${files2[@]} %equal% ${files[@]}
echo "OK"


keys=("a" "b" "c")
for ii in "${!keys[@]}"; do
    key="${keys[$ii]}"

    value=11
    eval $key=$value
    printf "Filter ($key=$value EQUAL): "
    files2=($(startup_filter_by_envvar EQUAL $key ${files[@]}))
    expect ${files2[@]} %nonempty%
    expect ${files2[@]} %equal% ${files[@]}
    echo "OK"

    value=1
    jj=$ii
    truth=(${files[@]/${files[$jj]}})
    eval $key=$value
    printf "Filter ($key=$value EQUAL): "
    files2=($(startup_filter_by_envvar EQUAL $key ${files[@]}))
    expect ${files2[@]} %equal% ${truth[@]}
    echo "OK"

    value=1
    eval $key=$value
    printf "Filter ($key=$value NOT_EQUAL): "
    files2=($(startup_filter_by_envvar NOT_EQUAL $key ${files[@]}))
    expect ${files2[@]} %equal% ${files[@]}
    echo "OK"

    value=11
    jj=$(($ii + 3))
    truth=(${files[@]/${files[$jj]}})
    eval $key=$value
    printf "Filter ($key=$value NOT_EQUAL): "
    files2=($(startup_filter_by_envvar NOT_EQUAL $key ${files[@]}))
    expect ${files2[@]} %equal% ${truth[@]}
    echo "OK"
done

echo "TEST STATUS: OK"
