module Constraints
  class Constant
    attr_reader :value
    attr_reader :connector

    def initialize(value, connector)
      @value = value
      @connector = connector
    end

    def me
      self
    end

    def call
      connector.connect(me)
      connector.set_value! value, me
      me
    end
  end
end
