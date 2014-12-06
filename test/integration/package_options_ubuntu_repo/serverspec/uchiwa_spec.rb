require 'spec_helper'

describe 'Installation' do
  it 'Has the uchiwa packaged installed' do
    expect(package 'uchiwa').to be_installed
  end

  it 'Created a package log file' do
    expect(file '/tmp/uchiwa_pkg.log').to be_file
  end
end

describe 'Configuration' do
  it_behaves_like 'service'
  it_behaves_like 'port'
  it_behaves_like 'configuration file'
end
