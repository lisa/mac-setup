# Customize the system
# Make directories, chown, etc

SHELL := /bin/bash

include verbose.mk

all: $(HOME)/go macprefs

$(HOME)/go:
	$(AT)mkdir -m 755 $(HOME)/go

.PHONY: macprefs
macprefs:
	$(AT)defaults write com.apple.finder AppleShowAllFiles YES || true
