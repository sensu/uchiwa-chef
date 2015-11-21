name             'uchiwa'
maintainer       'Justin Kolberg'
maintainer_email 'amd.prophet@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures uchiwa'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.0'

depends          'yum'
depends          'apt'

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
