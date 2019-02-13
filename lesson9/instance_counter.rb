# InstanceCounter module
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # ClassMethods module
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # InstanceMethods module
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
