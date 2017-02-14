#
# cookbook name:: uchiwa
# recipe:: configure
#
# copyright (c) 2014 jean-francois theroux
#
# licensed under the apache license, version 2.0 (the "license");
# you may not use this file except in compliance with the license.
# you may obtain a copy of the license at
#
#    http://www.apache.org/licenses/license-2.0
#
# unless required by applicable law or agreed to in writing, software
# distributed under the license is distributed on an "as is" basis,
# without warranties or conditions of any kind, either express or implied.
# see the license for the specific language governing permissions and
# limitations under the license.

# generate config file
#

settings = {}
node['uchiwa']['settings'].each do |k, v|
  settings[k] = v
end
config = { 'uchiwa' => settings, 'sensu' => node['uchiwa']['api'] }

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
