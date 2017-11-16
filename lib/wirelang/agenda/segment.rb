module Wirelang
  class Agenda
    class Segment
      attr_accessor :time
      attr_accessor :queue

      def initialize(time, queue = [])
        @time = time
        @queue = queue
      end
    end
  end
end
