SHELL:=/bin/bash

all: README.md test check


.PHONY: check test-summary

check:
	shellcheck bash-startup

test: test-run test-summary

test-run: tests/*.sh
	@echo "RUNNING TESTS:"
	@for ff in $$(LC_ALL=C printf "%s\n" $^ | sort); do \
	    printf "* $$ff"; \
	    echo "Running test: $$ff" > $$ff.log 2>&1; \
	    $$ff > $$ff.log 2>&1; \
	    grep -c -F "TEST STATUS: OK" $$ff.log | sed 's/0/: FAILED/' | sed 's/1/: OK/'; \
	done;

test-summary:
	@failed=$$(grep -c -F "TEST STATUS: OK" tests/*.sh.log | grep -F ":0" | sed 's/.log:0//'); \
	if test -n "$$failed"; then \
	    echo "FAILED TESTS:"; \
	    echo "$$failed"; \
	    echo "TEST OUTPUT:"; \
	    for ff in $$failed; do echo "TEST $$ff:"; cat $$ff.log; done; \
	else \
	    echo "PASSED ALL TESTS"; \
	fi

README.md: README.md.tmpl bash-startup
	@bfr=`cat $<`; \
	help=`. bash-startup --help`; \
	bfr=`echo "$${bfr/\{\{ HELP \}\}/$$help}"`; \
	bfr=`echo "$${bfr//%/%%}"`; \
	printf "$$bfr" > $@
	@echo "$@"
