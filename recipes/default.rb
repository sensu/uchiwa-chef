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

include_recipe 'uchiwa::install'

template '/etc/sensu/uchiwa.js' do
  user node['uchiwa']['user']
  group node['uchiwa']['group']
  mode 0640
  notifies :restart, 'service[uchiwa]'
end

service 'uchiwa' do
  action [:enable, :start]
end
