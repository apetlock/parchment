require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rdoc/task'

desc 'Run RSpec tests'
RSpec::Core::RakeTask.new :spec
task test: :spec

desc 'Generate RDoc documentation'
RDoc::Task.new :doc do |rdoc|
  rdoc.rdoc_files.include('Parchment.rdoc', 'lib/**/*.rb')
  rdoc.main = 'Parchment.rdoc'
  rdoc.rdoc_dir = 'doc'
  rdoc.options << '--force-update'
end

desc 'Launch library console'
task :console do
  sh 'irb -I lib -r parchment'
end

desc 'description'
task :default do
  puts 'Available commands: test, doc, console'
end
