class Person 

  attr_accessor :node

  NAMES = %w{erik tia roby simo martina giulia katia
             mary gio frengo omar priscilla alessio
             stefania stefano lucia ema genoveffa callisto
             chistro dylan mimmo}

  def self.create(attrs)
    new Neography::Node.create attrs.merge(_class: to_s)
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
    table['data'].map {|a| NEO.delete_node! a[0]}
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
    @node.neo_id
  end

end



