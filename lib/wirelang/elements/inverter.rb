module Wirelang
  module Elements
    class Inverter
      attr_reader :agenda
      attr_reader :input
      attr_reader :output

      def initialize(agenda, input, output)
        @agenda = agenda
        @input = input
        @output = output
      end

      def call
        action = lambda do
          signal = logical_not(input.signal)
          agenda.after_delay(
            agenda.delays[:inverter],
            -> { output.set_signal!(signal) }
          )
        end

        input.add_action!(&action)

        self
      end

      def logical_not(signal_value)
        case signal_value
        when 0 then 1
        when 1 then 0
        else raise 'Unknown signal'
        end
      end
    end
  end
end
