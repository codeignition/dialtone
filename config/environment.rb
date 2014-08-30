# encoding: utf-8

require 'bundler'
Bundler.setup

require 'adhearsion'

Bundler.require(:default, Adhearsion.environment)
Adhearsion.root = File.expand_path File.join(File.dirname(__FILE__), '../')
Dir[File.join(Adhearsion.root, 'config') + '/initializers/**/*.rb'].sort.each { |f| require f }


$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../app/')))
autoload_dirs = Dir[File.join(Adhearsion.root, 'app/**')]
autoload_dirs.each do |path|
  Dir["#{path}/*.rb"].sort.each do |f|
    require f
  end
end

