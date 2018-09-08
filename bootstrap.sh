#!/bin/bash

# Install Homebrew and Ansible


if [[ ! $(which xcodebuild) || ! $(which xcode-select) ]]; then
  echo "Can't find Xcode installed. Use the App Store to install it since it is"
  echo "a pre-requisite for Homebrew"
  exit 1
else
  echo "Enter password to accept xcode license"
  sudo -- sh -c 'xcodebuild -license accept ; xcode-select -s /Applications/Xcode.app/Contents/Developer'
fi

if [[ ! $(which brew) ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ ! $(which ansible) ]]; then
  brew update
  brew install ansible
fi

echo "Run with:"
echo "ansible-playbook -i hosts setup.yaml"
