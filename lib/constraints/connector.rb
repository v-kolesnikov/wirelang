module Constraints
  class Connector
    attr_reader :value
    attr_reader :informant
    attr_reader :constraints

    def initialize
      @value = false
      @informant = false
      @constraints = []
    end

    def value?
      informant ? true : false
    end

    def for_each_except_setter(setter, message)
      constraints.reject { |constraint| constraint == setter }
                 .each   { |constraint| constraint.public_send(message) }
    end

    def set_value!(new_value, setter)
      if !value?
        @value = new_value
        @informant = setter
        for_each_except_setter(setter, :process_new_value)
      elsif value != new_value
        raise "Error! Contradiction (#{value}, #{new_value})"
      else :ignored
      end
    end

    def forget_value!(retractor)
      return :ignored unless retractor == informant

      @informant = false
      for_each_except_setter retractor, :process_forget_value
    end

    def connect(constraint)
      constraints << constraint unless constraints.include? constraint
      constraint.process_new_value if value?
    end
  end
end
