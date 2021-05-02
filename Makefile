.PHONY: examples
examples:
	$(MAKE) -C examples/01
	$(MAKE) -C examples/02
	$(MAKE) -C examples/03
	$(MAKE) -C examples/04

.PHONY: clean
clean:
	find examples \( -name '*.wasm' -o -name '*.wast' -o -name '*.o' \) -exec rm {} \;
