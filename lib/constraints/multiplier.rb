module Constraints
  class Multiplier
    attr_reader :m1, :m2, :product

    def initialize(m1, m2, product)
      @m1 = m1
      @m2 = m2
      @product = product
    end

    def me
      self
    end

    def process_new_value
      if m1.value? && m1.value.zero? || m2.value? && m2.value.zero?
        product.set_value! 0, me
      elsif m1.value? && m2.value?
        product.set_value!(m1.value * m2.value, me)
      elsif m1.value? && product.value?
        m2.set_value!(product.value / m1.value, me)
      elsif m2.value? && product.value?
        m1.set_value!(product.value / m2.value, me)
      end
    end

    def process_forget_value
      product.forget_value! me
      m1.forget_value! me
      m2.forget_value! me
      process_new_value
    end

    def call
      m1.connect(me)
      m2.connect(me)
      product.connect(me)
      me
    end
  end
end
