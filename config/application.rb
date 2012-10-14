# anything regarding the app logic

require 'rubygems'
require 'neography'
# require 'pry'


Dir['./lib/**/*.rb', './models/**/*.rb'].each(&method(:require))

$neo = Neography::Rest.new



