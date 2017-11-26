require 'constraints/connector'
require 'constraints/constant'
require 'constraints/adder'
require 'constraints/multiplier'

module Constraints
  class CelsiusFahrenheitConverter
    attr_reader :celcius_connector
    alias c celcius_connector

    attr_reader :fahrenheit_connector
    alias f fahrenheit_connector

    attr_reader :u, :v, :w, :x, :y

    def initialize(celcius_connector, fahrenheit_connector)
      @celcius_connector = celcius_connector
      @fahrenheit_connector = fahrenheit_connector

      @u = Constraints::Connector.new
      @v = Constraints::Connector.new
      @w = Constraints::Connector.new
      @x = Constraints::Connector.new
      @y = Constraints::Connector.new
    end

    def call
      Constraints::Multiplier.new(c, w, u).()
      Constraints::Multiplier.new(v, x, u).()
      Constraints::Adder.new(v, y, f).()
      Constraints::Constant.new(9, w).()
      Constraints::Constant.new(5, x).()
      Constant.new(32, y).()
      :ok
    end
  end
end
