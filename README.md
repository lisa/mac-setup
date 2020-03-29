# mac-setup
Set up a MacOS computer with Make

## Usage

The installation will set up:

1. XCode by prompting the installation from the Mac Store (and then accepting the license)
2. Installing Homebrew manager
3. Installing Homebrew packages specified in the [Brewfile](./Brewfile)
4. Performing any customizations (see [customize.mk](./customize.mk))
5. Installing [rvm](./rvm/README.md)

### From Scratch

```shell
git clone https://github.com/lisa/mac-setup.git
cd mac-setup
make DOTFILE_PW="passphrase to decrypt or a file ref" all
make clean
```

### Updating HomeBrew Packages

`make install-brewfile`

# TODO

* Improve docs
* Checkout dotfiles to a temporary directory
