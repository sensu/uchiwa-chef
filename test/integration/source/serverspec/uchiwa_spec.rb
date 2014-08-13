require 'spec_helper'

describe 'Uchiwa' do
  it 'Installs dependencies' do
    expect(package 'git').to be_installed
    expect(package 'nodejs').to be_installed
  end

  it 'Creates homedir for Sensu & Uchiwa' do
    expect(file '/opt/uchiwa/usr/src/uchiwa').to be_directory
    expect(file '/etc/sensu').to be_directory
  end

  it 'Installs bower' do
    expect(command 'npm ls -g 2> /dev/null | grep bower').to return_exit_status 0
  end

  it 'Installs bower components' do
    expect(file '/opt/uchiwa/usr/src/uchiwa/public/bower_components').to be_directory
  end

  it 'Install init script' do
    expect(file '/etc/init.d/uchiwa').to be_file
  end

  it 'Enables and starts the Uchiwa service' do
    expect(service 'uchiwa').to be_enabled
    expect(service 'uchiwa').to be_running
  end

  it 'Listens on port TCP/3000' do
    expect(port 3000).to be_listening 'tcp'
  end

  it 'Has a configuration file' do
    expect(file '/etc/sensu/uchiwa.json').to be_file
    expect(file '/etc/sensu/uchiwa.json').to be_mode '640'
    expect(file '/etc/sensu/uchiwa.json').to be_owned_by 'uchiwa'
    expect(file '/etc/sensu/uchiwa.json').to be_grouped_into 'uchiwa'
  end
end
