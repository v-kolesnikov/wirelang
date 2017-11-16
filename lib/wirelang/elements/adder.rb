module Wirelang
  module Elements
    class Adder
      attr_reader :agenda
      attr_reader :input_a
      attr_reader :input_b
      attr_reader :input_c
      attr_reader :output_s
      attr_reader :output_c
      attr_reader :wire_s1
      attr_reader :wire_c1
      attr_reader :wire_c2

      def initialize(agenda, input_a, input_b, input_c, output_s, output_c)
        @agenda = agenda
        @input_a = input_a
        @input_b = input_b
        @input_c = input_c
        @output_s = output_s
        @output_c = output_c

        @wire_s1 = Wirelang::Wire.new
        @wire_c1 = Wirelang::Wire.new
        @wire_c2 = Wirelang::Wire.new
      end

      def call
        Wirelang::Elements::HalfAdder
          .new(agenda, input_b, input_c, wire_s1, wire_c1).()

        Wirelang::Elements::HalfAdder
          .new(agenda, input_a, wire_s1, output_s, wire_c2).()

        Wirelang::Elements::OrGate
          .new(agenda, wire_c1, wire_c2, output_c).()

        self
      end
    end

    FullAdder = Adder
  end
end
