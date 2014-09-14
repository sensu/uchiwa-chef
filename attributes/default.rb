# Global
default['uchiwa']['version'] = '0.2.3-1'
default['uchiwa']['install_method'] = 'package'
default['uchiwa']['apt_repo_url'] = 'http://repos.sensuapp.org/apt'
default['uchiwa']['yum_repo_url'] = 'http://repos.sensuapp.org'
default['uchiwa']['use_unstable_repo'] = false
default['uchiwa']['source_url'] = 'https://github.com/sensu/uchiwa.git'
default['uchiwa']['owner'] = 'uchiwa'
default['uchiwa']['group'] = 'uchiwa'
default['uchiwa']['sensu_homedir'] = '/etc/sensu'
default['uchiwa']['uchiwa_homedir'] = '/opt/uchiwa/usr/src/uchiwa'
default['uchiwa']['add_repo'] = true

# Set to false if you want to wrap this with runit or another process monitor
default['uchiwa']['manage_service'] = true

# Uchiwa Settings
default['uchiwa']['settings']['user'] = 'admin'
default['uchiwa']['settings']['pass'] = 'supersecret'
default['uchiwa']['settings']['stats'] = 10
default['uchiwa']['settings']['refresh'] = 10000
default['uchiwa']['settings']['host'] = '0.0.0.0'
default['uchiwa']['settings']['port'] = 3000

# APIs Settings
default['uchiwa']['api'] = [
  {
    'name' => 'Sensu',
    'host' => '127.0.0.1',
    'port' => 4567,
    'path' => '',
    'ssl' => false,
    'timeout' => 5000
  }
]
