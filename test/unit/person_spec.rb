describe Person do

  before :each do
    Person.delete_all
  end

  after :all do
    Person.delete_all
  end

  describe :count_all do
    it "should return 0 if there is no-one in the graph" do
      Person.count_all.should == 0
    end
    
    it "should return 2 if there are 2 people in the graph" do
      Person.create name: 'erik'
      Person.create name: 'tia'
      Person.create name: 'roby'
      Person.count_all.should == 3
    end
  end

  describe :create do
    it "should return a Person" do
      Person.create(name: 'livia').should be_an_instance_of Person
    end
    
    it "should store the name in the index" do
      name = 'roger'
      Person.create name: name
      $neo.get_node_index('Person', 'name', name).should be_an_instance_of Array
    end
  end

  describe :find_by_name do
    it "should return an existing person" do
      Person.create name: 'erik'
      Person.find_by_name('erik').should be_an_instance_of Person
    end

   it "should have a valid node in person" do
      Person.create name: 'erik'
      node = Person.find_by_name('erik').node rescue 'person is nil'
      node.should be_an_instance_of Neography::Node
   end
  end

  describe :sample do
    it "should return nil when there's no-one" do
      Person.sample.should be_nil
    end
    
    it "should return a Person" do
      Person.create name: 'tom'
      Person.create name: 'mark'
      Person.create name: 'roy'
      p = Person.sample
      p.should be_an_instance_of Person
      p.node['_class'].should == 'Person'
    end
  end

  describe :make_friendship_with do
    
    it "should create a friends relationships between two nodes" do
      pif = Person.create name: 'pif'
      tom = Person.create name: 'tom'
      pif.make_friendship_with tom
      pif.friend_with?(tom).should == true # TODO be_true true for hash?
    end
  end

  describe :father_of do
    it "should return the father of the sun" do
      son = Person.create name: 'son'
      father = Person.new name: 'father'
      son.father = father
      son.father.neo_id.should == father.neo_id
    end
  end

  describe :son do
    it "should return the father of the sun" do
      son = Person.create name: 'son'
      father = Person.new name: 'father'
      son.father = father
      father.son.neo_id.should == son.neo_id
    end
  end

end

