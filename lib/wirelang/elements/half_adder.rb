module Wirelang
  module Elements
    class HalfAdder
      attr_reader :agenda
      attr_reader :input_a
      attr_reader :input_b
      attr_reader :output_s
      attr_reader :output_c
      attr_reader :wire_d
      attr_reader :wire_e

      def initialize(agenda, input_a, input_b, output_s, output_c)
        @agenda = agenda
        @input_a = input_a
        @input_b = input_b
        @output_s = output_s
        @output_c = output_c

        @wire_d = Wirelang::Wire.new
        @wire_e = Wirelang::Wire.new
      end

      def call
        Wirelang::Elements::OrGate
          .new(agenda, input_a, input_b, wire_d).()

        Wirelang::Elements::AndGate
          .new(agenda, input_a, input_b, output_c).()

        Wirelang::Elements::Inverter
          .new(agenda, output_c, wire_e).()

        Wirelang::Elements::AndGate
          .new(agenda, wire_d, wire_e, output_s).()

        self
      end
    end
  end
end
