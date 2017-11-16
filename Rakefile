require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:lint)

RSpec::Core::RakeTask.new(:spec)

task default: :spec
