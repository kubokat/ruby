# InstanceCounter module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # ClassMethods module
  module ClassMethods

    attr_reader :validation_list

    def validate(name, type, param = nil)
      @validation_list ||= []
      @validation_list << { name: name, type: type, param: param }
    end
  end

  # InstanceMethods module
  module InstanceMethods
    def validate_empty(value)
      raise 'value is empty' if value.nil? || value == ''
    end

    def validate_format(value, format)
      raise 'invalid format' if value !~ format
    end

    def validate_type(value, type)
      raise 'type error' unless value.is_a?(type)
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validation_list.each do |validation|
        value = instance_variable_get("@#{validation[:name]}".to_sym)
        method_name = "validate_#{validation[:type]}".to_sym
        send(method_name, value, validation[:params])
      end
    end
  end
end