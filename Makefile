.PHONY: test-summary

test: test-run test-summary

test-run: tests/*.sh
	@echo "RUNNING TESTS:"
	@for ff in $^; do \
	    echo "Running test: $$ff"; \
	    echo "Running test: $$ff" > $$ff.log 2>&1; \
	    $$ff > $$ff.log 2>&1; \
	done;
	@echo "-------------"

test-summary:
	@echo "TEST SUMMARY:"
	@grep -c -F "TEST STATUS: OK" tests/*.sh.log
	@echo "FAILED TESTS:"
	$(grep -c -F "TEST STATUS: OK" tests/*.sh.log | grep -F ":0")
	@echo "-------------"
