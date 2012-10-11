class Person 

  attr_accessor :node

  NAMES = %w{erik tia roby simo martina giulia katia
             mary gio frengo omar priscilla alessio
             stefania stefano lucia ema genoveffa callisto
             chistro dylan mimmo}

  def self.create(attrs)
    node = Neography::Node.create attrs.merge _class: to_s
    $neo.add_node_to_index to_s, 'name', node['name'], node
    new node
  end

  def self.sample
    data = Sql.execute_query(:find_all_by_class, _class: to_s)['data']
    if data.any?
      node_h = data.shuffle[0][0]
      new Neography::Node.new(node_h)
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
    new Neography::Node.load(id)
  end

  def initialize(arg)
    @node = case arg
    when Hash            then Neography::Node.new(arg)
    when Neography::Node then arg
    end
  end

  def neo_id
    @node.neo_id.to_i
  end

  def make_friendship_with(person)
    $neo.create_relationship 'friends', node, person.node
    $neo.create_relationship 'friends', person.node, node
  end

    # type: in, out, all
    # def add_relationships(name_types, other_node)
    # $neo.create_relationship("friends", node1, node2)
    # $neo.create_relationship _class, node_hash, other.node_hash
    # args = name_types.map do |name, type = 'all'|
    #   [
    #     name.to_s,
    #     type,
    #     node_hash,
    #     other_node.hash,
    #     {:_class => name.to_s}.merge(attrs)
    #   ]
    # end
    # $neo.batch args
    # end

end



