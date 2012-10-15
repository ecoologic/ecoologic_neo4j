# anything regarding the app logic

require 'neography'


Dir['./lib/**/*.rb', './models/**/*.rb'].each(&method(:require))

$neo = Neography::Rest.new



