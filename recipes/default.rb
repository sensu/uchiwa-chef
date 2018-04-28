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

api_settings = node['uchiwa']['api']

# Retrieve the data bag config
data_bag_name = node['uchiwa']['data_bag']['name']
config_item = node['uchiwa']['data_bag']['config_item']

uchiwa_config = Uchiwa::Helpers.data_bag_item(data_bag_name, config_item, true)

if uchiwa_config
  # If any data bag settings exists, merge them with the node attribute settings
  if uchiwa_config['settings']
    merged_settings = Chef::Mixin::DeepMerge.merge(uchiwa_config['settings'], settings.to_hash)
    settings = merged_settings
  end

  # If the data bag is used for api settings, override the node attributes
  if uchiwa_config['api']
    api_settings = uchiwa_config['api']
  end
end

config = {'uchiwa' => settings, 'sensu' => api_settings}

template "#{node['uchiwa']['sensu_homedir']}/uchiwa.json" do
  user node['uchiwa']['owner']
  group node['uchiwa']['group']
  mode '0640'
  notifies :restart, 'service[uchiwa]' if node['uchiwa']['manage_service']
  variables(:config => JSON.pretty_generate(config))
end

service 'uchiwa' do
  action [:enable, :start] if node['uchiwa']['manage_service']
end
