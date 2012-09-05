#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rake/testtask'

desc 'Default: run specs, then tests.'
task :default => [:spec, :test]

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb' # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Run Sam G's test suite"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
