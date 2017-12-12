.PHONY: test-summary

test: test-run test-summary

test-run: tests/*.sh
	@echo "-------------------------------------------begin"
	@echo "RUNNING TESTS:"
	@for ff in $^; do \
	    printf "* $$ff"; \
	    echo "Running test: $$ff" > $$ff.log 2>&1; \
	    $$ff > $$ff.log 2>&1; \
	    grep -c -F "TEST STATUS: OK" $$ff.log | sed 's/0/: FAILED/' | sed 's/1/: OK/'; \
	done;
	@echo "---------------------------------------------end"

test-summary:
	@echo "-------------------------------------------begin"
	@echo "FAILED TESTS:"
	@grep -c -F "TEST STATUS: OK" tests/*.sh.log | grep -F ":0" | sed 's/.log:0//'
	@echo "---------------------------------------------end"
