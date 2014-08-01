#
# Cookbook Name:: uchiwa
# Recipe:: install
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

case node['platform_family']
  when 'debian'
    apt_repository 'sensu' do
      uri node['uchiwa']['apt_repo_url']
      key "#{node['uchiwa']['apt_repo_url']}/pubkey.gpg"
      distribution 'sensu'
      components node['uchiwa']['use_unstable_repo'] ? ["unstable"] : ["main"]
      only_if { node['uchiwa']['add_repo'] }
    end
  when 'rhel'
    branch = node['uchiwa']['use_unstable_repo'] ? 'yum-unstable' : 'yum'

    # Packages are only built for Centos/RHEL 6
    raise "Unsupported platform version #{version}. Aborting." if node['platform_version'].to_i < 6

    yum_repository 'uchiwa' do
      description 'Uchiwa repository'
      baseurl "#{node['uchiwa']['yum_repo_url']}/#{branch}/el/6/$basearch/"
      gpgcheck false
      only_if { node['uchiwa']['add_repo'] }
    end
  else
    raise "Unsupported platform family #{node['platform_family']}. Aborting."
end

package 'uchiwa' do
  options '--nogpgcheck' if node['platform_family'] == 'rhel'
  version node['uchiwa']['version']
end
