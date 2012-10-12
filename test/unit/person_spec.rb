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
      $neo.get_node_index('Person', 'name', name).should_not be_nil
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

end

