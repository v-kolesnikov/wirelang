module Constraints
  class Probe
    attr_reader :notifications
    attr_reader :name
    attr_reader :connector

    def initialize(name, connector, notifications = [])
      @notifications = notifications
      @name = name
      @connector = connector
    end

    def process_new_value
      notifications << {
        name: name,
        value: connector.value
      }
    end

    def process_forget_value
      notifications << {
        name: name,
        value: nil
      }
    end

    def call
      connector.connect(self)
    end
  end
end
