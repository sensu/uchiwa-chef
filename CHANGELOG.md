# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

## [v2.1.0] - 2018-05-15
### Added
- rescue on `Chef::Exceptions::InvalidDataBagItemID` when a data bag doesn't exist changed (@bleything)

## [v2.0.1] - 2018-05-14
### Fixed
- removed `apt` recipe that is no longer needed see #65, #66 for details (@bleything)

## [v2.0.0] - 2018-04-29
### Breaking Change
- now requires at least `chef-client >= 12.14` and removes the dependency on `apt` and `yum` cookbooks as they are now chef official resources (@tas50)

## [v1.5.0] - 2018-03-25
### Added
- `libraries/uchiwa_helpers.rb`: Add the ability to store settings in chef-vault

## [v1.4.0] 2017-09-16
### Added
- add the ability to optionally store uchiwa settings in a databag (supports encrypted data bags)

## [v1.3.0] - 2017-04-11
### Changed
- Bump default Uchiwa version to 0.23.1
- Use new repository layout (releasever & codename)

## [v1.2.0] 2015-11-21
### Changed
- Bump default Uchiwa version to 0.12.1
- Use new repository URL (repositories.sensuapp.org)

## [v1.1.0] - 2015-05-27
### Changed
- Bump default Uchiwa version to 0.8.1

### Added
- Allow for automatic restarts when a new version is installed

## [v1.0.0] - 2014-12-09
### Changed
- Bump default Uchiwa version to 0.4.0

## [v0.7.0] - 2014-12-08
### Changed
- Set default package options (apt/dpkg/yum)

### Added
- Allow default package options to be overridden


[Unreleased]: https://github.com/sensu/uchiwa-chef/compare/v2.1.0...HEAD
[v2.1.0]: https://github.com/sensu/uchiwa-chef/compare/v2.0.1...v2.1.0
[v2.0.1]: https://github.com/sensu/uchiwa-chef/compare/v2.0.0...v2.0.1
[v2.0.0]: https://github.com/sensu/uchiwa-chef/compare/v1.5.0...v2.0.0
[v1.5.0]: https://github.com/sensu/uchiwa-chef/compare/v1.4.0...v1.5.0
[v1.4.0]: https://github.com/sensu/uchiwa-chef/compare/1.3.0...v1.4.0
[v1.3.0]: https://github.com/sensu/uchiwa-chef/compare/1.2.0...1.3.0
[v1.2.0]: https://github.com/sensu/uchiwa-chef/compare/1.1.0...1.2.0
[v1.1.0]: https://github.com/sensu/uchiwa-chef/compare/1.0.0...1.1.0
[v1.0.0]: https://github.com/sensu/uchiwa-chef/compare/0.7.0...1.0.0
