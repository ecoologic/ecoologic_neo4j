class Person 

  def initialize(arg)
    @node = if arg.is_a? Hash
              Neography::Node.new(arg)
            elsif arg.is_a? Neography::Node
              arg
            end
  end

  attr_accessor :node

  NAMES = %w{erik tia roby simo martina giulia katia
             mary gio frengo omar priscilla alessio
             stefania stefano lucia ema genoveffa callisto
             chistro dylan mimmo}


  def self.create(attrs)
    # non atomic:
    # node = Neography::Node.create attrs.merge _class: to_s
    # $neo.add_node_to_index to_s, 'name', node['name'], node
    
    # atomic:
    name = attrs[:name] || attrs['name'] # the index wouldn't work without this!
    batch = $neo.batch [:create_node, attrs.merge(_class: to_s)],
                       [:add_node_to_index, to_s, 'name', name, '{0}'] # {0} is the result of the first line
    new batch[0]['body']
  end

  def self.sample
    data = Sql.execute_query(:find_all_by_class, _class: to_s)['data']
    if data.any?
      node_h = data.shuffle[0][0]
      new node_h
    end
  end

  def self.count_all
    data = Sql.execute_query(:count_all_by_class, _class: to_s)['data']
    data.any? ? data[0][0] : 0
  end

  def self.delete_all
    table = Sql.execute_query(:find_all_by_class, _class: to_s)
    table['data'].map {|a| $neo.delete_node! a[0]}
  end

  def self.load(id)
    node = Neography::Node.load id
    new node if node
  end

  def self.find_by_name(name)
    # without index:
    # data = Sql.execute_query(:find_by_name, name: name, _class: to_s)['data']
    
    # using index
    data = $neo.get_node_index 'Person', 'name', name
    new data[0] if data
  end

  def to_s
    %{#<Person:#{neo_id} name="#{name}", born_in=#{born_in}>}
  end

  def name
    @node[:name]
  end

  def born_in
    @node[:born_in]
  end

  def neo_id
    @node.neo_id.to_i
  end

  def friend_with?(person, depth = 1)
    # algorithms: https://github.com/maxdemarzi/neography/blob/master/lib/neography/node_path.rb
    # FIXME: $node.simple_path_to(person.node).incoming(:friends).depth(depth) # nodes.any?

    $neo.get_path(node, person.node,
                  {"type"=> "friends", "direction" => "in"},
                  depth).any?
  end

  def make_friends_with(person, attrs = {})
    # non atomic:
    # $neo.create_relationship 'friends', node, person.node
    # $neo.create_relationship 'friends', person.node, node
    
    # atomic:
    $neo.batch [:create_relationship, 'friends', @node, person.node, attrs],
               [:create_relationship, 'friends', person.node, @node, attrs]
  end

  # TODO: refactor with make_friends_with 
  def make_brothers_with(person, attrs = {})
    year = born_in < person.born_in ? born_in : person.born_in
    $neo.batch [:create_relationship, 'brothers', @node, person.node, attrs.merge(since: year)],
               [:create_relationship, 'brothers', person.node, @node, attrs.merge(since: year)]
  end

  def delete!
    $neo.delete_node! @node
  end

  def friends(depth = 1)
    nodes = $neo.traverse(node,                                              # the node where the traversal starts
                      "nodes",                                            # return_type "nodes", "relationships" or "paths"
                      {"order" => "breadth first",                        # "breadth first" or "depth first" traversal order
                       "uniqueness" => "node global",                     # See Uniqueness in API documentation for options.
                       "relationships" => [{"type"=> "friends",         # A hash containg a description of the traversal
                                            "direction" => "all"}],       # possible directions: in, out, all
                       "depth" => depth})                                 # instead of a prune evaluator
    nodes.map{|n| Person.new n}    
  end

  def brothers
    nodes = $neo.traverse(node,                                              # the node where the traversal starts
                      "nodes",                                            # return_type "nodes", "relationships" or "paths"
                      {"order" => "breadth first",                        # "breadth first" or "depth first" traversal order
                       "uniqueness" => "node global",                     # See Uniqueness in API documentation for options.
                       "relationships" => [{"type"=> "brothers",         # A hash containg a description of the traversal
                                            "direction" => "all"}],       # possible directions: in, out, all
                       "depth" => 1})                                 # instead of a prune evaluator
    nodes.map{|n| Person.new n}    
  end


  def count_friends
    data = Sql.execute_query(:count_friends, id: neo_id)['data']
    data.any? ? data[0][0] : 0
  end

  def make_son(name, year)
    son = Person.create name: name, born_in: year
    $neo.create_relationship :father_of, @node, son.node, since: son.born_in
    son
  end

  def father
    @father ||= begin
      data = Sql.execute_query(:find_father, id: neo_id)['data']
      Person.new data[0][0] if data.any?
    end
  end

  def son
    @son ||= begin
      data = Sql.execute_query(:find_son, id: neo_id)['data']
      Person.new data[0][0] if data.any?
    end
  end


end



