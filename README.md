=== Ecoologi Neo4j

A first project to explore Neo4j.

== Install
Please note neo4j 1.8 is required as it has a more complete sql, such as possibility to use
delete and not only return in queries). The snapshot downloadable from the site worked with
no problems in Ubuntu simply running `bin/neo4j start`.

`.rvmrc` will create the gemset `ecoologic_neo4j` in ruby-1.9.3

`bundle`
`./main.rb`
`spec test.rb`


== Uninstall
`rvm gemset delete ruby-1.9.3@ecoologic_neo4j`



