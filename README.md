# Ecoologi Neo4j

A first project to explore Neo4j using [Neography](https://github.com/maxdemarzi/neography.git)
to stick with regular MRI ruby.

There is a sinatra application in the project but it's in a very early stage of development.
**I suggest reading focusing on tests and console** to get an understanding of what this little project is capable of,
which is basically CR(u)D of nodes and relationship creations both through batch (i.e. transactions) and not.

## Install
Please note [**neo4j 1.8**](http://neo4j.org/download-thanks/?edition=community&release=1.8)
is required as it has a more complete sql, such as possibility to use
delete and not only return in queries). The snapshot downloadable from the site worked with
no problems in Ubuntu simply running `bin/neo4j start`.

The file `.rvmrc` in the root of the project will create the gemset `ecoologic_neo4j` in ruby-1.9.3

    bundle
    rspec test.rb
    ruby console.rb

**Important:** I haven't found a way yet to namespace the nodes in a separate database, and the community doesn't
seem that much worried about this, but if you have valuable data in your neo server think twice before running this project
because it's my only project in neo4j.


## Uninstall

    rvm gemset delete ruby-1.9.3@ecoologic_neo4j
    # then remove the directory or the project and you've done

## Development notes

Run the tests with `ruby test.rb` and read `test/unit/person_spec.rb` and `models/person.rb` at this commit they're
all 14 running on my ubuntu machine.

`config/application.rb` will load the required dependencies and initialize the `$neo` neography server.
I very hardly use global variables in production, I'll move it in following refactors.

`$neo` usually returns `Hash` objects which I wrap with `Neography` and wrap again in the model objects (`Person`).

`lib/sql.rb` is a utility to read the queries stored in a yaml file, so all queries are in the same place.

`db/seeds.rb` is used for the console on which I started the project.

As I'm learning I'm trying to mix cypher queries and code access to data.

## Two words on Neo4j if you know what it is but you never used it
The neography server returns a hash of objects, filled in with api urls.
Nodes and relationships have their user-set attributes in `['data']`.
Queries put the resulting table in `['data']`, then in rows and columns, so for instance

    start n=node({id}) return n, id(n) # cypher query returning in table
    node    = table['data'][0][0]
    node_id = table['data'][0][1]





