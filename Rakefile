require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'
require 'bundler/setup'

desc 'Update exuberant-ctags'
task :etags do
  sh %{etags -R}
end

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test'
    t.test_files = FileList[ 'test/unit/*rb' ]
    t.verbose = false
  end
  Rake::TestTask.new(:integration) do |t|
    t.libs << 'test'
    t.test_files = FileList[ 'test/integration/*.rb' ]
    t.verbose = false
    # Uncomment for test runtime profiling.
    #t.options = '-v'
  end
  desc 'Run all tests'
  task :all => [ 'test:unit', 'test:integration' ]
end

task :default => [ 'test:unit' ]
