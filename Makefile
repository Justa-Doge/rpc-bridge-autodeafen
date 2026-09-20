.PHONY: all build clean package

all:
	$(MAKE) -C src all

build:
	$(MAKE) -C src build

clean:
	$(MAKE) -C src clean

package: build
	./packaging/build-package.sh
