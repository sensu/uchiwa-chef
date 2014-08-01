# Global
default['uchiwa']['version'] = '0.1.7-1'
default['uchiwa']['apt_repo_url'] = "http://repos.sensuapp.org/apt"
default['uchiwa']['yum_repo_url'] = "http://repos.sensuapp.org"
default['uchiwa']['use_unstable_repo'] = false
default['uchiwa']['owner'] = 'uchiwa'
default['uchiwa']['group'] = 'uchiwa'
default['uchiwa']['add_repo'] = true

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
    'ssl' => false,
    'timeout' => 5000
  }
]
