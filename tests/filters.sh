#!/usr/bin/env bash
. tests/init/load.sh

## Load functions
declare -a files=(
    "a=11/b/c.sh"
    "a/b=11/c.sh"
    "a/b/c=11.sh"
    
    "zzz.a=11/b/c.sh"
    "a/zzz.b=11/c.sh"
    "a/b/zzz.c=11.sh"

    "a!=11/b/c.sh"
    "a/b!=11/c.sh"
    "a/b/c!=11.sh"

    "zzz.a!=11/b/c.sh"
    "a/zzz.b!=11/c.sh"
    "a/b/zzz.c!=11.sh"

    "a/b/c"
)

echo "Files (n=${#files}):"
printf " * '%s'\\n" "${files[@]}"
expect "${files[@]}" %nonempty%

printf "Filter (nonexisting): "
# shellcheck disable=SC2207
files2=($(startup_filter_by_envvar EQUAL nonexisting "${files[@]}"))
expect "${files2[@]}" %nonempty%
expect "${files2[@]}" %equal% "${files[@]}"
echo "OK"


echo "startup_find_all_keys(n=${#files}):"
# shellcheck disable=SC2207
keys=($(startup_find_all_keys "${files[@]}"))
printf " * '%s'\\n" "${keys[@]}"
expect "${keys[@]}" %nonempty%
truth=("a" "b" "c")
expect "${keys[@]}" %equal% "${truth[@]}"

for ii in "${!keys[@]}"; do
    key="${keys[$ii]}"

    value=11
    eval "$key=$value"
    printf "Filter (%s=%s EQUAL): " "$key" "$value"
    # shellcheck disable=SC2207
    files2=($(startup_filter_by_envvar EQUAL "$key" "${files[@]}"))
    expect "${files2[@]}" %nonempty%
    expect "${files2[@]}" %equal% "${files[@]}"
    echo "OK"

    value=1
    # shellcheck disable=SC2206
    truth=(${files[@]})
    unset truth[$((ii + 3))]
    unset truth[$((ii))]
    eval "$key=$value"
    printf "Filter (%s=%s EQUAL): " "$key" "$value"
    # shellcheck disable=SC2207
    files2=($(startup_filter_by_envvar EQUAL "$key" "${files[@]}"))
    expect "${files2[@]}" %equal% "${truth[@]}"
    echo "OK"

    value=1
    eval "$key=$value"
    printf "Filter (%s=%s NOT_EQUAL): " "$key" "$value"
    # shellcheck disable=SC2207
    files2=($(startup_filter_by_envvar NOT_EQUAL "$key" "${files[@]}"))
    expect "${files2[@]}" %equal% "${files[@]}"
    echo "OK"

    value=11
    # shellcheck disable=SC2206
    truth=(${files[@]})
    unset truth[$((ii + 9))]
    unset truth[$((ii + 6))]
    eval "$key=$value"
    printf "Filter (%s=%s NOT_EQUAL): " "$key" "$value"
    # shellcheck disable=SC2207
    files2=($(startup_filter_by_envvar NOT_EQUAL "$key" "${files[@]}"))
    expect "${files2[@]}" %equal% "${truth[@]}"
    echo "OK"
done

echo "TEST STATUS: OK"
