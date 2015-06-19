Installs and configures [Uchiwa](https://github.com/sensu/uchiwa). A simple dashboard for [Sensu](http://sensuapp.org/). This cookbook uses the omnibus packages.

[![Build Status](https://travis-ci.org/sensu/uchiwa-chef.svg)](https://travis-ci.org/sensu/uchiwa-chef)

# Installation methods

The cookbook supports the following installation methods:

+ repo (default)
+ http

# Attributes

You can change the following attributes to configure uchiwa:

```
default['uchiwa']['settings']['user'] = 'admin'
default['uchiwa']['settings']['pass'] = 'supersecret'
default['uchiwa']['settings']['refresh'] = 5
default['uchiwa']['settings']['host'] = '0.0.0.0'
default['uchiwa']['settings']['port'] = 3000
```

> To disable authentication on uchiwa, set user and pass to *nil*

# Supported platforms

These platforms have been tested successfully.

+ Centos/RHEL 6 and 7 x86_64
+ Ubuntu 12.04 and 14.04 amd64

# Contributing

+ Smaller commits are better if we need to cherry pick.
+ Make sure foodcritic runs without errors.
+ Make sure 'knife cookbook test' runs without errors.
+ Make sure 'kitchen test' runs without errors.
+ Make sure 'rubocop' runs without errors.
+ Write tests for your change.

# Authors

* Author: Justin Kolberg (<amd.prophet@gmail.com>)
* Author: Jean-Francois Theroux (<me@failshell.io>)
