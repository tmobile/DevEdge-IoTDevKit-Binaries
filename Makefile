#
# Copyright (c) 2023 T-Mobile USA, Inc.
#

SOURCES_BIN	:= $(shell find * -type f -name '*.bin')
SOURCES_RPS	:= $(shell find * -type f -name '*.rps')
SOURCES_UA	:= $(shell find * -type f -name '*.ua')
TARGETS		:= $(SOURCES_BIN:%.bin=%.bin.sha1) $(SOURCES_RPS:%.rps=%.rps.sha1) $(SOURCES_UA:%.ua=%.ua.sha1)
SOURCE_DIRS	:= $(sort $(dir $(TARGETS)))

%.bin.sha1 : %.bin
	cd $(@D) && shasum $(<F) >$(@F)

%.rps.sha1 : %.rps
	cd $(@D) && shasum $(<F) >$(@F)

%.ua.sha1 : %.ua
	cd $(@D) && shasum $(<F) >$(@F)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	$(RM) $(TARGETS)

.PHONY: $(SOURCE_DIRS)
$(SOURCE_DIRS):
	@echo "$@:"; cd $@; for sha1_file in *.sha1; do shasum -c $$sha1_file; done

.PHONY: check
check: $(SOURCE_DIRS)
