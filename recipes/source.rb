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

package 'git'
include_recipe 'nodejs'

group node['uchiwa']['group']

user node['uchiwa']['owner'] do
  gid node['uchiwa']['group']
  system true
end

[node['uchiwa']['sensu_homedir'], node['uchiwa']['uchiwa_homedir']].each do |path|
  directory path do
    owner node['uchiwa']['owner']
    group node['uchiwa']['group']
    mode 0755
    recursive true
  end
end

execute 'install_bower' do
  command 'npm install -g bower'
  not_if "npm ls -g 2> /dev/null | grep 'bower'"
end

git node['uchiwa']['uchiwa_homedir'] do
  repository node['uchiwa']['source_url']
  revision node['uchiwa']['version']
  action :sync
  notifies :run, 'execute[install_dependencies]'
end

execute 'install_dependencies' do
  cwd node['uchiwa']['uchiwa_homedir']
  command 'npm install --production --unsafe-perm'
  action :nothing
end

template '/etc/init.d/uchiwa' do
  source 'uchiwa-init.erb'
  mode 0755
end
