# everything regarding the web

require 'sinatra'
require 'haml'
require 'sass'

require './ecoologic_neo4j.rb'

require './config/application.rb'
require './db/seeds.rb'

run EcoologicNeo4j
