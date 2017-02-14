require 'chefspec'
require 'chefspec/berkshelf'

def create_rsyslog_file_input(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:rsyslog_file_input, :create, resource_name)
end

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.log_level = :error
  config.formatter = :documentation
  config.color     = true
end

at_exit { ChefSpec::Coverage.report! }
