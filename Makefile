#
# Copyright (c) 2023 T-Mobile USA, Inc.
#

SOURCES_BIN	:= $(shell find * -type f -name '*.bin')
SOURCES_IMG	:= $(shell find * -type f -name '*.img')
SOURCES_RPS	:= $(shell find * -type f -name '*.rps')
SOURCES_UA	:= $(shell find * -type f -name '*.ua')

SOURCES		:= $(SOURCES_BIN) $(SOURCES_IMG) $(SOURCES_RPS) $(SOURCES_UA)
TARGETS		:= $(SOURCES:%=%.sha1)
SOURCE_DIRS	:= $(sort $(dir $(TARGETS)))

%.sha1: %
	cd $(@D) && shasum $(<F) >$(@F)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	$(RM) $(TARGETS)

.PHONY: check
check: $(SOURCE_DIRS)
	for dir in $^; do pushd "$$dir" >/dev/null; echo "$$PWD"; for file in *.sha1; do shasum -c "$$file"; done; popd >/dev/null; done
