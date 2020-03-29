SHELL := /bin/bash
WHOAMI := $(shell whoami)

XCODE ?= /Applications/Xcode.app
RUBY ?= /usr/bin/ruby
CURL ?= /usr/bin/curl
BREW := /usr/local/bin/brew

XCODE_URL := https://apps.apple.com/ca/app/xcode/id497799835?mt=12
HOMEBREW_INSTALL_URL := https://raw.githubusercontent.com/Homebrew/install/master/install

BREWFILE ?= $(shell pwd -P)/Brewfile
BREWFILE_LOCK := $(BREWFILE).lock.json

include verbose.mk
include reqs.mk

all: .xcode $(BREW) $(BREWFILE_LOCK) customize rvm dotfiles

# TODO: Does this dump a file somewhere?
# Accept xcode license
.xcode:
ifeq (,$(wildcard $(XCODE)))
	$(error XCode missing. Install with App Store, $(XCODE_URL))
else
	$(AT)echo "Enter password to accept the xcode license" ;\
	sudo -- sh -c 'xcodebuild -license accept && xcode-select -s $(XCODE)/Contents/Developer && date -u > $@ && chown $(WHOAMI) $@'
endif

# Install Homebrew
.PHONY: homebrew
homebrew: $(BREW)
$(BREW): .xcode
	$(AT)echo "Installing Homebrew from $(HOMEBREW_INSTALL_URL)" ;\
	$(RUBY) -e "$$($(CURL) -fsSL $(HOMEBREW_INSTALL_URL))"

.PHONY: install-brewfile
install-brewfile: $(BREWFILE_LOCK)
$(BREWFILE_LOCK): $(BREW) $(BREWFILE)
	$(AT)$(BREW) bundle install --file=$(BREWFILE) --no-upgrade

# Post-Homebrew things follow

.PHONY: customize
customize: .xcode $(BREW) $(BREWFILE_LOCK)
	$(AT)$(MAKE) -f customize.mk

.PHONY: dotfiles
dotfiles:
	$(AT)$(MAKE) CURL=$(CURL) DOTFILE_PW="$(DOTFILE_PW)" V=$(V) -C dotfiles

.PHONY: rvm
rvm:
	$(AT)$(MAKE) CURL=$(CURL) V=$(V) -C rvm

.PHONY: clean
clean:
	$(AT)for d in rvm dotfiles; do \
		$(MAKE) -C $$d clean ;\
	done


