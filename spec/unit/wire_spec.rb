RSpec.describe Wirelang::Wire do
  describe '#initialize' do
    it 'makes a new wire with signal = 0' do
      expect(described_class.new.signal).to eq 0
    end

    it 'makes a new wire with empty procs queue' do
      expect(described_class.new.procs).to be_empty
    end
  end
end
