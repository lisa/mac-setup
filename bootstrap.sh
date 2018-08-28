#!/bin/bash

# Install Homebrew and Ansible

if [[ ! $(which brew) ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# be ready to accept xcode license

if [[ ! $(which ansible) ]]; then
  brew update
  brew install ansible
fi

