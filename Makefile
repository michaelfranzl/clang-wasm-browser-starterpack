.PHONY: examples
examples:
	$(MAKE) -C examples/01
	$(MAKE) -C examples/02
	$(MAKE) -C examples/03
	$(MAKE) -C examples/04
	$(MAKE) -C examples/05
	$(MAKE) -C examples/06
	$(MAKE) -C examples/07
	$(MAKE) -C examples/10
	$(MAKE) -C examples/11

.PHONY: clean
clean:
	find examples \( -name '*.wasm' -o -name '*.wast' -o -name '*.o' \) -exec rm {} \;
