name             'uchiwa'
maintainer       'Justin Kolberg'
maintainer_email 'amd.prophet@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures uchiwa'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.5.0'

depends 'chef-vault', '>= 1.3.1'

%w(
  ubuntu
  debian
  centos
  redhat
  fedora
  amazon
).each do |os|
  supports os
end

source_url 'https://github.com/sensu/uchiwa-chef'
issues_url 'https://github.com/sensu/uchiwa-chef/issues'
chef_version '>= 12.14' if respond_to?(:chef_version)
