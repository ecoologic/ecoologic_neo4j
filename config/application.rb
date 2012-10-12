require 'rubygems'
require 'neography'
require 'pry'

$neo = Neography::Rest.new

Dir['./lib/**/*.rb', './app/**/*.rb', './db/*.rb'].each(&method(:require))



