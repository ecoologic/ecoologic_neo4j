#!/usr/bin/env ruby

puts "\n** Ecoologic Neo4j **\n"

require './config/application.rb'

Person.delete_all
erik = Person.create name: 'erik'
tia  = Person.create name: 'tia'

binding.pry

puts "\nbye\n"

