module Node

  module ClassMethods
    def create(attrs = {})
      Neography::Node.create attrs.merge({_class: self.class.to_s})
      # TODO: add to index and remove attr class
    end
  end



end

