# neo4j 1.8 delete everything
# TODO: remove?
$neo.execute_query "START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx"

names = Person::NAMES.shuffle

PEOPLE_POOL_SIZE = 20
PEOPLE_POOL_SIZE.times do |i|
  Person.create name: "#{names[i % names.size]} num#{i}",
                born_in: rand(1930..2010)
end
(PEOPLE_POOL_SIZE * 2).times {Person.sample.make_friendship_with Person.sample}

Person.create name: 'tia', born_in: 1980
marty = Person.create name: 'marty' , born_in: 1986

franco = Person.create name: 'franco', born_in: 1948
erik = franco.make_son 'erik', 1980
marty.make_friendship_with erik



