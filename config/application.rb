# anything regarding the app logic

require 'neography'
# require 'pry'


Dir['./lib/**/*.rb', './models/**/*.rb'].each(&method(:require))

$neo = Neography::Rest.new



