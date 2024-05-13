.PHONY: all
all:
	$(MAKE) -C 01
	$(MAKE) -C 02
	$(MAKE) -C 03
	$(MAKE) -C 04
	$(MAKE) -C 05
	$(MAKE) -C 06
	$(MAKE) -C 07
	$(MAKE) -C 10
	$(MAKE) -C 11

.PHONY: install
install:
	$(MAKE) -C 01 install
	$(MAKE) -C 02 install
	$(MAKE) -C 03 install
	$(MAKE) -C 04 install
	$(MAKE) -C 05 install
	$(MAKE) -C 06 install
	$(MAKE) -C 07 install
	$(MAKE) -C 10 install
	$(MAKE) -C 11 install

.PHONY: clean
clean:
	find . \( -name '*.wasm' -o -name '*.wast' -o -name '*.o' \) -exec rm {} \;
