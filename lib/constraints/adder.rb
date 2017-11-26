module Constraints
  class Adder
    attr_reader :a1, :a2, :sum

    def initialize(a1, a2, sum)
      @a1 = a1
      @a2 = a2
      @sum = sum
    end

    def me
      self
    end

    def process_new_value
      if a1.value? && a2.value?
        sum.set_value!(a1.value + a2.value, me)
      elsif a1.value? && sum.value?
        a2.set_value!(sum.value - a1.value, me)
      elsif a2.value? && sum.value?
        a1.set_value!(sum.value - a2.value, me)
      end
    end

    def process_forget_value
      sum.forget_value! me
      a1.forget_value! me
      a2.forget_value! me
      process_new_value
    end

    def call
      a1.connect(me)
      a2.connect(me)
      sum.connect(me)
      me
    end
  end
end
