#
# Cookbook Name:: uchiwa
# Recipe:: repo
#
# Copyright (C) 2014 Jean-Francois Theroux
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package_options = ''

platform_family = node['platform_family']
platform_version = node['platform_version'].to_i

case platform_family
when 'debian'
  package_options = '--force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew"'

  include_recipe 'apt'

  apt_repository 'sensu' do
    uri node['uchiwa']['apt_repo_url']
    key "#{node['uchiwa']['apt_repo_url']}/pubkey.gpg"
    distribution 'sensu'
    components node['uchiwa']['use_unstable_repo'] ? ['unstable'] : ['main']
    only_if { node['uchiwa']['add_repo'] }
  end
when 'rhel'
  package_options = '--nogpgcheck'
  branch = node['uchiwa']['use_unstable_repo'] ? 'yum-unstable' : 'yum'

  # Packages are only built for Centos/RHEL 6
  raise "Unsupported platform version #{platform_version}. Aborting." if platform_version < 6

  yum_repository 'uchiwa' do
    description 'Uchiwa repository'
    baseurl "#{node['uchiwa']['yum_repo_url']}/#{branch}/el/6/$basearch/"
    gpgcheck false
    only_if { node['uchiwa']['add_repo'] }
  end
else
  raise "Unsupported platform family #{platform_family}. Aborting."
end

package_options = node['uchiwa']['package_options'] || package_options

package 'uchiwa' do
  options package_options
  version node['uchiwa']['version']
  notifies :restart, 'service[uchiwa]' if node['uchiwa']['manage_service']
end
