module Wirelang
  module Elements
    class OrGate
      attr_reader :agenda
      attr_reader :input_a
      attr_reader :input_b
      attr_reader :output

      def initialize(agenda, input_a, input_b, output)
        @agenda = agenda
        @input_a = input_a
        @input_b = input_b
        @output = output
      end

      def call
        action = lambda do
          signal = logical_or(input_a.signal, input_b.signal)
          agenda.after_delay(
            agenda.delays[:or_gate],
            -> { output.set_signal!(signal) }
          )
        end

        input_a.add_action!(&action)
        input_b.add_action!(&action)

        self
      end

      def logical_or(signal1, signal2)
        signal1 == 1 || signal2 == 1 ? 1 : 0
      end
    end
  end
end
