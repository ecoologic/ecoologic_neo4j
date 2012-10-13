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

Person.create name: 'erik'
Person.create name: 'tia'
Person.create name: 'marty'

erik.father = Person.create name: 'franco'

erik.make_friendship_with tia
marty.make_friendship_with erik



