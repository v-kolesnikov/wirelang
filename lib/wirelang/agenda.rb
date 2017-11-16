module Wirelang
  class Agenda
    attr_accessor :time
    attr_accessor :segments
    attr_reader :delays

    DEFAULT_DELAYS = {
      inverter: 2,
      and_gate: 3,
      or_gate: 5
    }.freeze

    def initialize(delays: DEFAULT_DELAYS)
      @time = 0
      @segments = []
      @delays = delays
    end

    def empty?
      segments.empty?
    end

    def first_item!
      raise "Agenda is empty #{self}" if empty?

      segment = segments.first
      self.time = segment.time

      segment.queue.first
    end

    def remove_first_item!
      raise "Agenda is empty #{self}" if empty?

      first_segmnet = segments.first
      first_segmnet.queue.shift

      self.segments = segments[1..-1] if first_segmnet.queue.empty?
    end

    def add_action(time, action)
      segment = segments.find { |s| s.time == time }

      if segment
        segment.queue << action
      else
        new_segment = Segment.new(time, [action])
        seg_parts = segments.partition { |seg| seg.time < time }
        self.segments = seg_parts[0] + [new_segment] + seg_parts[1]
      end
    end

    def after_delay(time, action)
      add_action(self.time + time, action)
    end

    def propagate!
      until empty?
        first_item!.()
        remove_first_item!
      end

      :done
    end
    alias call propagate!
  end
end
