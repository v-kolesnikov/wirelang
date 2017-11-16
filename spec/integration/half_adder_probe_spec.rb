RSpec.describe Wirelang do
  describe 'half-adder with probe' do
    let(:agenda) do
      Wirelang::Agenda.new
    end

    let(:input_a) { Wirelang::Wire.new }
    let(:input_b) { Wirelang::Wire.new }
    let(:out_sum) { Wirelang::Wire.new }
    let(:carry) { Wirelang::Wire.new }

    let(:half_adder) do
      Wirelang::Elements::HalfAdder
        .new(agenda, input_a, input_b, out_sum, carry)
    end

    let(:changes) { [] }

    let(:probe) do
      lambda do |name, wire|
        wire.add_action! do
          changes << { name: name, time: agenda.time, signal: wire.signal }
        end
      end
    end

    before do
      probe.(:sum, out_sum)
      probe.(:carry, carry)

      half_adder.()
      input_a.set_signal!(1)
    end

    subject { agenda.propagate! }

    it do
      expect(changes).to eq [
        { name: :sum, time: 0, signal: 0 },
        { name: :carry, time: 0, signal: 0 }
      ]
    end

    it do
      expect { subject }.to change { changes }
        .by([{ name: :sum, time: 8, signal: 1 }])
    end

    it { expect { subject }.to change { agenda.time }.from(0).to(8) }
    it { expect { subject }.to change { out_sum.signal }.from(0).to(1) }

    context 'after set carry-input signal to 1' do
      before do
        agenda.propagate!
        input_b.set_signal!(1)
      end

      it { expect { subject }.to change { agenda.time }.from(8).to(16) }
    end
  end
end
