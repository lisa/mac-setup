# RVM Installation

Installs RVM and rubies [specified](./Makefile) in the `RVM_RUBY_VERSIONS` variable, for example, `ruby-2.4.4` and `ruby-2.5.1`.

Additionally configures [.rvmrc](./src/rvmrc) and [user overrides](./src/rvm_user_db).

## Usage

See the [parent Makefile](../Makefile), makes a reference to the [RVM Makefile](Makefile).

```shell
mac-setup $ make rvm
```

Using this directly:

```shell
mac-setup/rvm $ make CURL=/path/to/curl rvm
```
