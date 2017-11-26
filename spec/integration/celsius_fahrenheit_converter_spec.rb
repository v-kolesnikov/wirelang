RSpec.describe Constraints::CelsiusFahrenheitConverter do
  let(:c) { Constraints::Connector.new }
  let(:f) { Constraints::Connector.new }

  let(:converter) do
    Constraints::CelsiusFahrenheitConverter.new(c, f)
  end

  let(:output) { [] }

  before do
    Constraints::Probe.new('By Celsius', c, output).()
    Constraints::Probe.new('By Fahrenheit', f, output).()
    converter.()
  end

  context 'when C receives a new value' do
    it do
      expect { c.set_value! 25, :user }
        .to change { output }
        .from([])
        .to([{ name: 'By Celsius', value: 25 },
             { name: 'By Fahrenheit', value: 77 }])
    end
  end

  context 'when C has value' do
    before { c.set_value! 25, :user }

    context 'and F receives a new value' do
      it do
        expect { f.set_value! 212, :user }
          .to raise_error('Error! Contradiction (77, 212)')
      end
    end

    context 'and then forgets it' do
      it do
        expect { c.forget_value! :user }
          .to change { output }
          .by([{ name: 'By Celsius', value: nil },
               { name: 'By Fahrenheit', value: nil }])
      end

      context 'and F receives a new value' do
        it do
          c.forget_value! :user
          expect { f.set_value! 212, :user }
            .to change { output }
            .by([{ name: 'By Fahrenheit', value: 212 },
                 { name: 'By Celsius', value: 100 }])
        end
      end
    end
  end
end
