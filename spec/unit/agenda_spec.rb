RSpec.describe Wirelang::Agenda do
  describe '#initialize' do
    it 'makes a new agenda with time = 0' do
      expect(described_class.new.time).to eq 0
    end

    it 'makes a new agenda without any segments' do
      expect(described_class.new.segments).to be_empty
    end
  end

  describe '#first_item!' do
    let(:agenda) { described_class.new }

    subject { agenda.first_item! }

    context 'when agenda is empty' do
      it { expect { subject }.to raise_error(/Agenda is empty/) }
    end

    context 'when agenda has at least one segment' do
      let(:segment) { Wirelang::Agenda::Segment.new(1) }

      before do
        agenda.segments << segment
      end

      it do
        expect { subject }.to change { agenda.time }
          .from(0)
          .to(segment.time)
      end
    end
  end

  describe '#remove_first_item!' do
    let(:agenda) { described_class.new }

    subject { agenda.remove_first_item! }

    context 'when agenda is empty' do
      it { expect { subject }.to raise_error(/Agenda is empty/) }
    end

    context 'when agenda has segments' do
      let(:segment1) { Wirelang::Agenda::Segment.new(1) }
      let(:segment2) { Wirelang::Agenda::Segment.new(2) }

      before do
        agenda.segments << segment1
        agenda.segments << segment2
      end

      it do
        expect { subject }.to change { agenda.segments }
          .from([segment1, segment2])
          .to([segment2])
      end
    end
  end

  describe '#add_action' do
    let(:agenda) { described_class.new }

    subject { agenda.add_action(time, action) }

    let(:time) { 1 }
    let(:action) { proc {} }
    let(:new_segment) do
      Wirelang::Agenda::Segment.new(time, [action])
    end

    before do
      # Needs only for test checks
      def new_segment.==(other)
        return unless other.is_a?(self.class)
        queue == other.queue && time == other.time
      end
    end

    context 'when agenda is empty' do
      it do
        expect { subject }.to change { agenda.segments }
          .from([])
          .to([new_segment])
      end
    end

    context 'when agenda has segment with same time' do
      let(:same_time_segment) do
        Wirelang::Agenda::Segment.new(time, [action])
      end

      before do
        agenda.segments << same_time_segment
      end

      it do
        expect { subject }.to change { same_time_segment.queue }
          .from([action])
          .to([action, action])
      end
    end
  end
end
