#!/usr/bin/env ruby

puts 'Ecoologic Neo4j Tests only'

Dir['./app/*.rb', './test/*.rb'].each(&method(:require))

