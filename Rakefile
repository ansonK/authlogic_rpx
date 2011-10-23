ENV['RDOCOPT'] = "-S -f html -T hanna"

require 'rubygems'
require 'rake'
require 'bundler'

Bundler.setup

require File.dirname(__FILE__) << "/lib/authlogic_rpx/version"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "authlogic_rpx"
    gem.version = AuthlogicRpx::Version::STRING
    gem.summary = %Q{Authlogic plug-in for RPX support}
    gem.description = %Q{Authlogic extension/plugin that provides RPX (rpxnow.com) authentication support}
    gem.email = "gallagher.paul@gmail.com"
    gem.homepage = "http://github.com/tardate/authlogic_rpx"
    gem.authors = [ "Paul Gallagher / tardate <gallagher.paul@gmail.com>" ]
    gem.add_dependency 'activesupport', '>= 3.0.7'
    gem.add_dependency 'authlogic', '>= 3.1.0'
    gem.add_dependency 'rpx_now', '>= 0.6.24'
    gem.add_development_dependency 'rails', '>= 3.0.7'
    gem.add_development_dependency 'test-unit', '>= 2.2.2'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << 'test'
    t.libs << 'test/integration'
    t.libs << "test/libs"
    t.pattern = 'test/unit/*test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:no_mapping) do |t|
    t.libs << 'test'
    t.libs << 'test/integration'
    t.libs << "test/libs"
    t.test_files = FileList.new('test/unit/*test.rb', 'test/integration/no_mapping/*test.rb')
    t.verbose = true
  end

  Rake::TestTask.new(:internal_mapping) do |t|
    t.libs << 'test'
    t.libs << 'test/integration'
    t.libs << "test/libs"
    t.test_files = FileList.new('test/integration/internal_mapping/*test.rb')
    t.verbose = true
  end
end

task :test do
  Rake::Task['test:no_mapping'].invoke
  Rake::Task['test:internal_mapping'].invoke
end

task :default => :test
