# neo4j 1.8 delete everything
# TODO: remove?
$neo.execute_query "START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx"

names = Person::NAMES.shuffle

40.times {|i| Person.create name: "#{names[i % names.size]} num#{i}"}
60.times {Person.sample.make_friendship_with Person.sample}

erik  = Person.create name: 'erik'
tia   = Person.create name: 'tia'
marty = Person.create name: 'marty'
marisa = Person.create name: 'marisa'
erik.mother = marisa

erik.make_friendship_with tia
marty.make_friendship_with erik



