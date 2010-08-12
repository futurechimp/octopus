require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "octopus"
    gem.summary = %Q{An experimental octopus implementation.}
    gem.description = %Q{Grabs stuff off the net and notifies interested subscribers.}
    gem.email = "dave.hrycyszyn@headlondon.com"
    gem.homepage = "http://github.com/futurechimp/octopus"
    gem.authors = ["dave@boomer"]
    gem.add_dependency "data_mapper", ">= 1.0.0"
    gem.add_dependency "dm-sqlite-adapter", ">= 1.0.0"
    gem.add_dependency "sinatra", ">= 0.9.4"
    gem.add_dependency "thin", ">= 1.2.5"
    gem.add_dependency "rack-flash", ">= 0.1.1"
    gem.add_dependency "rack", ">= 1.0.1"
    gem.add_development_dependency "shoulda", ">= 2.10.2"
    gem.add_development_dependency "rack-test", ">= 0.5.2"
    gem.add_development_dependency "machinist", ">= 1.0.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "octopus #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

