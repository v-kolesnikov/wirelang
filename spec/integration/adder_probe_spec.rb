RSpec.describe Wirelang do
  describe 'half-adder with probe' do
    let(:agenda) do
      Wirelang::Agenda.new
    end

    let(:input_a) { Wirelang::Wire.new }
    let(:input_b) { Wirelang::Wire.new }
    let(:input_c) { Wirelang::Wire.new }
    let(:output_s) { Wirelang::Wire.new }
    let(:output_c) { Wirelang::Wire.new }

    let(:adder) do
      Wirelang::Elements::Adder
        .new(agenda, input_a, input_b, input_c, output_s, output_c)
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
      probe.(:sum, output_s)
      probe.(:carry, output_c)
      adder.()
    end

    subject { agenda.propagate! }

    context 'when input signals are 0 and 1' do
      before do
        input_a.set_signal!(0)
        input_b.set_signal!(1)
      end

      it do
        expect { subject }.to change { changes }
          .by([{ name: :sum, time: 16, signal: 1 }])
      end

      it { expect { subject }.to change { agenda.time }.from(0).to(16) }
      it { expect { subject }.to change { output_s.signal }.from(0).to(1) }
      it { expect { subject }.not_to change { output_c.signal }.from(0) }
    end

    context 'when input signal are 1 and 1' do
      before do
        input_a.set_signal!(1)
        input_b.set_signal!(1)
      end

      it do
        expect { subject }.to change { changes }
          .by([{ name: :sum,   time: 8,  signal: 1 },
               { name: :carry, time: 16, signal: 1 },
               { name: :sum,   time: 16, signal: 0 }])
      end

      it { expect { subject }.to change { agenda.time }.from(0).to(16) }
      it { expect { subject }.not_to change { output_s.signal }.from(0) }
      it { expect { subject }.to change { output_c.signal }.from(0).to(1) }
    end
  end
end
