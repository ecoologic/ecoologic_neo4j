require 'rubygems'
require 'neography'
require 'pry'

Dir['./lib/**/*.rb', './app/**/*.rb'].each(&method(:require))

$neo = Neography::Rest.new



