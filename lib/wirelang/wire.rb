module Wirelang
  class Wire
    attr_reader :signal
    attr_reader :procs

    def initialize
      @signal = 0
      @procs = []
    end

    def add_action!(&action)
      procs << action
      yield
    end

    def set_signal!(signal)
      raise "Unknown signal #{signal}" unless [0, 1].include?(signal)

      if self.signal != signal
        @signal = signal
        call_each
      end

      :done
    end

    def call_each
      procs.each(&:call)
    end
  end
end
