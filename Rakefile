require 'rake/testtask'

Rake::TestTask.new("test") do |t|
  t.libs.push "lib"
  t.libs.push "test"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test
