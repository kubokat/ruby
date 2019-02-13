# Module Accessors
module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_history_name = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_history_name) }
      define_method("#{name}=".to_sym) do |value|
        last_val = instance_variable_get(var_name)
        instance_variable_set(var_name, value)

        attribute_history = instance_variable_get(var_history_name)
        if attribute_history.nil?
          instance_variable_set(var_history_name, [])
        else
          instance_variable_get(var_history_name) << last_val
        end
      end
    end
  end

  def strong_attr_accessor(name, type)
    define_method(name) { instance_variable_get("@#{name}".to_sym) }

    define_method("#{name}=".to_sym) do |value|
      raise TypeError, 'Type error' unless value.is_a?(type)

      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end