require 'spec_helper'

describe 'Uchiwa' do
  it 'Install the package uchiwa' do
    expect(package 'uchiwa').to be_installed
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
