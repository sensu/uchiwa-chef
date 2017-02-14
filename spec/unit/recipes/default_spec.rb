#
# Cookbook Name:: uchiwa
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'uchiwa::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do
      end.converge(described_recipe)
    end

    before(:each) do
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('uchiwa::repo')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates uchiwa config' do
      expect(chef_run).to create_template('/etc/sensu/uchiwa.json').with(
        user: 'uchiwa',
        group: 'uchiwa'
      )
    end

    it 'enables uchiwa service' do
      expect(chef_run).to enable_service('uchiwa')
    end

    it 'starts uchiwa service' do
      expect(chef_run).to start_service('uchiwa')
    end
  end

  context 'When all attributes are default, on a centos 7.2, using repo install method' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511', platform_family: 'rhel') do |node|
        node.set['uchiwa']['install_method'] = 'repo'
        node.set['uchiwa']['sensu_homedir'] = '/etc/sensu'
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates uchiwa repo' do
      expect(chef_run).to create_yum_repository('uchiwa').with(
        baseurl: 'http://repositories.sensuapp.org/yum/el/7/$basearch/'
      )
    end

    it 'installs uchiwa from repo' do
      expect(chef_run).to install_package('uchiwa')
    end
  end

  context 'When all attributes are default, on a centos 7.2, using repo custom url install method' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511', platform_family: 'rhel') do |node|
        node.set['uchiwa']['install_method'] = 'repo'
        node.set['uchiwa']['yum_repo_url'] = 'http://different.repository.com'
        node.set['uchiwa']['yum_repo_url_suffix'] = 'new/suffix/url'
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates uchiwa repo' do
      expect(chef_run).to create_yum_repository('uchiwa').with(
        baseurl: 'http://different.repository.com/new/suffix/url'
      )
    end
  end

  context 'When all attributes are default, on a ubuntu 16.04, using repo install method' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04', platform_family: 'debina') do |node|
        node.set['uchiwa']['install_method'] = 'repo'
        node.set['uchiwa']['sensu_homedir'] = '/etc/sensu'
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates uchiwa repo' do
      expect(chef_run).to add_apt_repository('sensu').with(
        uri: 'http://repositories.sensuapp.org/apt'
      )
    end

    it 'installs uchiwa from repo' do
      expect(chef_run).to install_package('uchiwa')
    end
  end

  context 'When all attributes are default, on a centos 7.2, using http install method' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511', platform_family: 'rhel') do |node|
        node.set['uchiwa']['install_method'] = 'http'
        node.set['uchiwa']['sensu_homedir'] = '/etc/sensu'
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads uchiwa rpm package' do
      arch = chef_run.node['kernel']['machine'] == 'i686' ? 'i686' : chef_run.node['kernel']['machine']
      pkg = "uchiwa-#{chef_run.node['uchiwa']['version']}.#{arch}.rpm"
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/#{pkg}").with(
        source: "#{chef_run.node['uchiwa']['http_url']}/#{pkg}"
      )
    end

    it 'installs uchiwa from downloaded rpm package' do
      arch = chef_run.node['kernel']['machine'] == 'i686' ? 'i686' : chef_run.node['kernel']['machine']
      pkg = "uchiwa-#{chef_run.node['uchiwa']['version']}.#{arch}.rpm"
      expect(chef_run).to install_package(pkg)
    end
  end

  context 'When all attributes are default, on a ubuntu 16.04, using http install method' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04', platform_family: 'debina') do |node|
        node.set['uchiwa']['install_method'] = 'http'
        node.set['uchiwa']['sensu_homedir'] = '/etc/sensu'
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads uchiwa deb package' do
      arch = chef_run.node['kernel']['machine'] == 'x86_64' ? 'amd64' : 'i386'
      pkg = "uchiwa_#{chef_run.node['uchiwa']['version']}_#{arch}.deb"
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/#{pkg}").with(
        source: "#{chef_run.node['uchiwa']['http_url']}/#{pkg}"
      )
    end

    it 'installs uchiwa from downloaded deb package' do
      arch = chef_run.node['kernel']['machine'] == 'x86_64' ? 'amd64' : 'i386'
      pkg = "uchiwa_#{chef_run.node['uchiwa']['version']}_#{arch}.deb"
      expect(chef_run).to install_dpkg_package(pkg)
    end
  end
end
