.PHONY: examples
examples:
	$(MAKE) -C 01
	$(MAKE) -C 02
	$(MAKE) -C 03
	$(MAKE) -C 04
	$(MAKE) -C 05
	$(MAKE) -C 06
	$(MAKE) -C 07
	$(MAKE) -C 10
	$(MAKE) -C 11

.PHONY: clean
clean:
	find . \( -name '*.wasm' -o -name '*.wast' -o -name '*.o' \) -exec rm {} \;
