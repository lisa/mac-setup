## Install RVM
__PWD := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
GPG ?= /usr/local/bin/gpg

RVM_INSTALL := https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
RVM_GPG_KEYSERVER := hkp://pool.sks-keyservers.net
RVM_GPG_KEYS := 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RVM := $(HOME)/.rvm/bin/rvm

# Install at least these versions
RVM_RUBY_VERSIONS ?= ruby-2.4.4 ruby-2.5.1
RVM_RUBIES := $(foreach r,$(RVM_RUBY_VERSIONS),$(HOME)/.rvm/rubies/$(r))
__RVM_USER_DB_FILE_SRC := src/rvm_user_db
__RVMRC_SRC := src/rvmrc
INSTALL ?= /usr/bin/install

BREWFILE ?= $(__PWD)../Brewfile

# if called directly, provide a defaul
AT ?= @

all: rvm
rvm: $(RVM_RUBIES)

ifeq (,$(wildcard $(CURL)))
	$(error Can't find curl. Retry with make CURL=/path/to/curl)
endif
ifeq (,$(wildcard $(GPG)))
	$(error Can't find gpg. Retry with make GPG=/path/to/gpg)
endif
ifeq (,$(wildcard $(INSTALL)))
	$(error Can't find $(INSTALL). Retry with make INSTALL=/path/to/install)
endif

$(RVM):
	$(AT)if [[ $$($(GPG) --list-keys $(RVM_GPG_KEYS) | grep -c ^pub) != "$$(($$(echo $(RVM_GPG_KEYS) | grep -c ' ') + 1))" ]]; then \
		echo "Don't have enough GPG keys for RVM. Importing them..." ;\
		$(GPG) --keyserver $(RVM_GPG_KEYSERVER) --recv-keys $(RVM_GPG_KEYS) ;\
	fi ;\
	echo "Installing RVM from $(RVM_INSTALL)" ;\
	$(CURL) $(RVM_INSTALL) | bash -s stable

.PHONY: install-rubies
install-rubies: $(RVM_RUBIES)
$(RVM_RUBIES): $(RVM) $(HOME)/.rvmrc $(HOME)/.rvm/user/db
	$(AT)echo "Installing $(shell basename $@)..." ;\
	$(RVM) install $(shell basename $@)

## Put the .rvmrc into place
$(HOME)/.rvmrc: $(__RVMRC_SRC)
	$(AT)$(INSTALL) -b -m 644 -o $(shell id -u $(USER)) -g $(shell id -g $(USER)) $(__RVMRC_SRC) $@

## Put ~/.rvm/user/db into place so Ruby is installed correctly
$(HOME)/.rvm/user/db: $(__RVM_USER_DB_FILE_SRC)
	$(AT)$(INSTALL) -d -o $(shell id -u $(USER)) -g $(shell id -g $(USER)) $(HOME)/.rvm/user
	$(AT)$(INSTALL) -b -m 644 -o $(shell id -u $(USER)) -g $(shell id -g $(USER)) $(__RVM_USER_DB_FILE_SRC) $@

.PHONY: clean
clean:
	$(AT)# noop