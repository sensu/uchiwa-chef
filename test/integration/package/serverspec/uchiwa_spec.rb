require 'spec_helper'

describe 'Installation' do
  it 'Has the uchiwa packaged installed' do
    expect(package 'uchiwa').to be_installed.with_version('0.2.3-1')
  end
end

describe 'Configuration' do
  it_behaves_like 'uchiwa'
end
