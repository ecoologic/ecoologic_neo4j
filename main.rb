#!/usr/bin/env ruby

puts "\n** Ecoologic Neo4j **\n"

require 'pry'

Dir['./app/*.rb'].each(&method(:require))

binding.pry

puts "\nbye\n"
