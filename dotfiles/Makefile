# Install dotfiles
# 1. Fetch from Github to ./dotrc-master
# 2. Ensure the password is in place
# 3. Hand off execution to ./dotrc-master/Makefile

__PWD := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all: fetch-dotfiles $(SECURE_PW) process

ifeq (,$(wildcard $(CURL)))
	$(error Can't find curl at $(CURL). Try make CURL=/path/to/curl)
endif

# To turn this envvar into $(SECURE_PW) file
ifeq (,$(DOTFILE_PW))
	$(error You must set DOTFILE_PW with make to decrypt the secure blob.)
endif

# in case not called from ../Makefile with verbose.mk ref
AT ?= @

# Where the dotfiles live in Git, as a zipfile
__DOTRC_GIT_SRC ?= https://github.com/lisa/dotrc/archive/master.zip
# dotrc checkout desination, after curl | unzip
DOTRC_GIT_CHECKOUT_DEST ?= $(__PWD)/dotrc-master
# this is the actual place on disk
SECURE_PW := $(DOTRC_GIT_CHECKOUT_DEST)/decrypt_pw

.PHONY: fetch-dotfiles
fetch-dotfiles: $(DOTRC_GIT_CHECKOUT_DEST)
$(DOTRC_GIT_CHECKOUT_DEST):
	$(AT)mkdir -m 700 -p $@ ;\
	$(CURL) -fsSL $(__DOTRC_GIT_SRC) | tar -xf -

# Put all the dotfiles into place by using the Makefile we pulled and extracted
.PHONY: process
process: fetch-dotfiles
	$(AT)$(MAKE) V=$(V) -C $(DOTRC_GIT_CHECKOUT_DEST) || \rm -rf $(DOTRC_GIT_CHECKOUT_DEST)
	$(AT)\rm -rf $(DOTRC_GIT_CHECKOUT_DEST) 2>/dev/null

# Dump the password from $DOTFILE_PW environment variable out to disk for the
# de-encryption. If it's a reference to a file, copy it into place
.PHONY: pw
pw: $(SECURE_PW)
$(SECURE_PW): fetch-dotfiles
	$(AT)oldmask=$$(umask) ;\
	umask 077 ;\
	touch $@ ;\
	if [[ -r "$(DOTFILE_PW)" ]]; then \
		cat "$(DOTFILE_PW)" > $@ ;\
	else \
		echo "$(DOTFILE_PW)" > $@ ;\
	fi ;\
	umask $$oldmask

.PHONY: clean
clean:
	$(AT)\rm -rf $(DOTRC_GIT_CHECKOUT_DEST)