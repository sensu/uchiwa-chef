require 'rspec/core/rake_task'

# syntax/lint checks: RuboCop & Foodcritic
namespace :lint do
  require 'rubocop/rake_task'
  require 'foodcritic'

  desc 'Run Ruby syntax/lint checks'
  RuboCop::RakeTask.new(:ruby) do |task|
    task.options = [
      '--no-color'
    ]
    # don't abort rake on failure
    task.fail_on_error = false
  end

  desc 'Run Chef syntax/lint checks'
  FoodCritic::Rake::LintTask.new(:chef) do |task|
    task.options = {
      tags: ['~FC037'],
      fail_tags: ['any']
    }
  end
end

desc 'Run all syntax/lint checks'
task lint: ['lint:ruby', 'lint:chef']

# unit testing: ChefSpec
desc 'Run RSpec and ChefSpec unit tests'
RSpec::Core::RakeTask.new(:unit) do |rspec|
  rspec.rspec_opts = '--color  --format documentation --format html ' \
                     '--out reports/rspec_results.html --format RspecJunitFormatter ' \
                     '--out reports/rspec_results.xml'
end

# integration testing: Test Kitchen
namespace :integration do
  require 'kitchen'

  desc 'Run Test Kitchen integration tests with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

desc 'Run all integration tests'
task integration: ['integration:vagrant']

desc 'Run all travis tests'
# task default: %w(lint unit integration)
task default: %w(lint unit)
