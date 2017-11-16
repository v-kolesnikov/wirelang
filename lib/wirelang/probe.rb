module Werilang
  class Probe
    attr_reader :name
    attr_reader :wire
    attr_reader :changes

    def initialize(name, wire)
      @name = name
      @wire = wire
      @changes = []
    end

    def set!
      wire.add_action! do
        changes << { name: name, time: agenda.time, signal: wire.signal }
      end
    end
  end
end
