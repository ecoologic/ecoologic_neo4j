class Person

  extend Node::ClassMethods


  NAMES = %w{erik tia roby simo martina giulia katia
             mary gio frengo omar priscilla alessio
             stefania stefano lucia ema genoveffa callisto
             chistro dylan mimmo}

  def self.pool(n = 50)
    n.times do |i|
      Person.new name: "#{NAMES.sample} n#{i}",
                  age: rand(0..80)
    end

    n.times do
      person = Person.sample
      person.make_mutual_friend_with Person.sample # TODO: person.non_friends.sample
    end
  end

end



