require 'serverspec'

set :backend, :exec

shared_examples_for 'service' do
  it 'Enables and starts the Uchiwa service' do
    expect(service 'uchiwa').to be_enabled
    expect(service 'uchiwa').to be_running
  end
end

shared_examples_for 'disabled service' do
  it 'Uchiwa service is disabled and not running' do
    expect(service 'uchiwa').to_not be_enabled
    expect(service 'uchiwa').to_not be_running
  end
end

shared_examples_for 'port' do
  it 'Listens on port TCP/3000' do
    expect(port 3000).to be_listening 'tcp'
  end
end

shared_examples_for 'configuration file' do
  it 'Has a configuration file' do
    expect(file '/etc/sensu/uchiwa.json').to be_file
    expect(file '/etc/sensu/uchiwa.json').to be_mode '640'
    expect(file '/etc/sensu/uchiwa.json').to be_owned_by 'uchiwa'
    expect(file '/etc/sensu/uchiwa.json').to be_grouped_into 'uchiwa'
  end
end
