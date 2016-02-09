require "bundler"
Bundler.require

require 'sinatra/activerecord/rake'
require 'rake/testtask'

task default: [:deftask]
task :deftask do
  puts 'call rake -T'
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end
