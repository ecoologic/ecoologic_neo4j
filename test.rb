#!/usr/bin/env rspec
# FIXME

puts 'Ecoologic Neo4j Tests only'

require './config/application.rb'

require 'rspec'
Dir['./test/**/*.rb'].each(&method(:require))

