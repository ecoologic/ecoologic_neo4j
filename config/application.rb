require 'rubygems'
require 'neography'
require 'pry'
Dir['./lib/**/*.rb', './app/**/*.rb'].each(&method(:require))


$neo = Neography::Rest.new
$neo.execute_query("START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx")

