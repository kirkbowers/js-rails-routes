# -*- ruby -*-

require "rubygems"
require "hoe"
require "rdoc2md"

# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
# Hoe.plugin :minitest
# Hoe.plugin :racc
# Hoe.plugin :rcov
# Hoe.plugin :rubyforge

Hoe.spec "js-rails-routes" do
  developer("Kirk Bowers", "kirkbowers@yahoo.com")

  license "MIT" # this should match the license in the README
end

desc 'Compile CoffeeScript files into JavaScript and copy into the lib directory'
task :coffee do
  puts "Compiling CoffeeScript files"
  sh 'coffee -b -c coffee/*.coffee'
  cp Dir.glob('coffee/*.js'), 'lib/js-rails-routes/js/'
end

desc 'Build the gem and install it locally'
task :build => [:coffee, :gem, :install_gem]

desc 'Build the gem, install it locally, and test it'
Rake::Task[:default].prerequisites.clear
task :default => [:build, :test]

desc 'Builds the gem, tests it, and generates the README.md file.  Do before checking in!'
task :all => [:build, 'README.md', :test]

# vim: syntax=ruby
