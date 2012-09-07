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

desc "find TODO items"
task :todo do
  puts `ack -h --ruby '#\s*TODO.*'`
end

desc "run benchmarks"
task :performance do
  IO.popen('ruby etc/performance.rb') do |data|
    while line = data.gets
      puts line
    end
  end
end
