# Customize the system
# Make directories, chown, etc

SHELL := /bin/bash

include verbose.mk

all: $(HOME)/go

$(HOME)/go:
	$(AT)mkdir -m 755 $(HOME)/go
