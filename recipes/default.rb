#
# Cookbook Name:: uchiwa
# Recipe:: default
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

include_recipe "uchiwa::#{node['uchiwa']['install_method']}"

# Generate config file
settings = {}
node['uchiwa']['settings'].each do |k, v|
  settings[k] = v
end
config = { 'uchiwa' => settings, 'sensu' => node['uchiwa']['api'] }

template "#{node['uchiwa']['sensu_homedir']}/uchiwa.json" do
  user node['uchiwa']['owner']
  group node['uchiwa']['group']
  mode 0640
  notifies :restart, 'service[uchiwa]' if node['uchiwa']['manage_service']
  variables(:config => JSON.pretty_generate(config))
end

service 'uchiwa' do
  action [:enable, :start] if node['uchiwa']['manage_service']
end
