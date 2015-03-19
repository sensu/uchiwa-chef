#
# Cookbook Name:: uchiwa
# Recipe:: http
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

platform_family = node['platform_family']

case platform_family
when 'debian'
  package_options = node['uchiwa']['package_options'] || '--force-confdef --force-confnew'

  arch = if node['kernel']['machine'] == 'x86_64'
    'amd64'
  else
    'i386'
  end

  pkg = "uchiwa_#{node['uchiwa']['version']}_#{arch}.deb"
  url = "#{node['uchiwa']['http_url']}/#{pkg}"

  remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
    source url
  end

  dpkg_package pkg do
    options package_options
    source "#{Chef::Config[:file_cache_path]}/#{pkg}"
    notifies :restart, 'service[uchiwa]' if node['uchiwa']['manage_service']
  end
when 'rhel'
  package_options = node['uchiwa']['package_options'] || '--nogpgcheck'

  arch = if node['kernel']['machine'] == 'i686'
    'i386'
  else
    node['kernel']['machine']
  end

  pkg = "uchiwa-#{node['uchiwa']['version']}.#{arch}.rpm"
  url = "#{node['uchiwa']['http_url']}/#{pkg}"

  remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
    source url
  end

  package pkg do
    options package_options
    source "#{Chef::Config[:file_cache_path]}/#{pkg}"
    notifies :restart, 'service[uchiwa]' if node['uchiwa']['manage_service']
  end
else
  raise "Unsupported platform family #{node['platform_family']}. Aborting."
end
