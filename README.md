# fish k - A fast kubectl tool for deterministic k8s access

# Install

* Install fundle
  https://github.com/tuvistavie/fundle
* Add plugin to config.fish with fundle

The easiest way to install fundle and plugin is to add the following to your `~/.config/fish/config.fish` file:

    # installing fundle if not installed
    if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

    # adding plugin to current fish session
    fundle plugin 'lixhq/fish-k'

    # init selected plugins
    fundle init

# Usage

fish-k comes with autocompletion so most options should be visible that way.

Get started by writing:

    lb <context> <namespace> <kubectl stardard commands>

Then get fx pods:

    k un-k8s production get pods
