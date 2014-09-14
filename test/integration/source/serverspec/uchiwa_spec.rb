require 'spec_helper'

describe 'Installation' do
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
end

describe 'Configuration' do
  it_behaves_like 'uchiwa'
end
