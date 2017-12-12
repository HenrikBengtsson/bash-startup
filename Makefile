

test: tests/*.sh
	for ff in $^; do \
	    echo "Running test: $$ff"; \
	    echo "Running test: $$ff" > $$ff.log 2>&1; \
	    $$ff > $$ff.log 2>&1; \
	done
