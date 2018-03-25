Installs and configures [Uchiwa](https://github.com/sensu/uchiwa). A simple dashboard for [Sensu](http://sensuapp.org/). This cookbook uses the omnibus packages.

[![Build Status](https://travis-ci.org/sensu/uchiwa-chef.svg)](https://travis-ci.org/sensu/uchiwa-chef)

# Installation methods

The cookbook supports the following installation methods:

+ repo (default)
+ http

# Supported platforms

These plateforms have been tested successfully.

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

## Build and Release

For maintainers looking to release new versions of this cookbook you should follow this process:
1. Add any `README.md` and `CHANGELOG.md` changes with links to Pull Requests. Commit this to develop branch.
1. Update `CHANGELOG.md` with new version header and update diff links.
1. Create a commit to then tag for release I would suggest something like this `git commit -am 'prep for v$MAJOR.$MINOR.$RELEASE release'`. Commit this to develop and make sure that everything is good to go (ci passing and such).
1. Push from develop to master: `git push origin develop:master`
1. checkout master branch and pull in changes: `git checkout master && git pull`
1. Create a tagged release: `hub release create v$MAJOR.$MINOR.$PATCH` this should prompt you in an editor to modify the tag message. I typically leave it default, but feel free to include any useful release notes.
1. Use the `stove` command to push the newly versioned cookbook to the supermarket: `stove --no-git`. This assumes that you have installed `stove`, properly configured authentication, and have been granted access to the supermarket.
1. Optionally but recommended to update any associated PRs with a release link.
