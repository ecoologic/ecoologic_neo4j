# TODO: This should be a class and it should be extended (<<)
module Node

  module ClassMethods

  end

  def initialize(node)
    @node = node
  end

  def delete_by_class
    NEO.execute_query("start n=node(*) where n._class! = 'Class' return n")['data'].map{|a| NEO.delete_node! a[0]}
  end

end

