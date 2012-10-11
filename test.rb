#!/usr/bin/env ruby

puts 'Ecoologic Neo4j Tests only'

require 'config/application.rb'
Dir['./test/*.rb'].each(&method(:require))



