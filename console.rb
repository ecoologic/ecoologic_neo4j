#!/usr/bin/env ruby

puts "\n** Ecoologic Neo4j **\n"

require './config/application.rb'
require './db/seeds.rb' unless ARGV[0] == '--no-seeds'

# binding.pry # TODO: stopped working?




puts "\nbye\n"

