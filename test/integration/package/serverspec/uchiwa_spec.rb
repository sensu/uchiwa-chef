require 'spec_helper'

describe 'Installation' do
  it 'Has the uchiwa packaged installed' do
    expect(package 'uchiwa').to be_installed.with_version('0.5.1-1')
  end
end

describe 'Configuration' do
  it_behaves_like 'service'
  it_behaves_like 'port'
  it_behaves_like 'configuration file'
end
