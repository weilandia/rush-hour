require "bundler"
Bundler.require

require "sinatra/activerecord/rake"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end
