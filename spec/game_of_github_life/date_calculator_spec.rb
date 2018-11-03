RSpec.describe GameOfGithubLife::DateCalculator do
  describe '#start_date' do
    subject { described_class.start_date(year) }

    context '2018-10-28' do
      before { Timecop.freeze('2018-10-28') }
      after { Timecop.return }

      context 'nil' do
        let(:year) { nil }

        it { is_expected.to eq Time.new(2017, 10, 29, 12) }
      end

      context '2018' do
        let(:year) { 2018 }

        it { is_expected.to eq Time.new(2017, 12, 31, 12) }
      end
    end

    context '2017' do
      let(:year) { 2017 }

      it { is_expected.to eq Time.new(2017, 1, 1, 12) }
    end

    context '2016' do
      let(:year) { 2016 }

      it { is_expected.to eq Time.new(2015, 12, 27, 12) }
    end

    context '2000' do
      let(:year) { 2000 }

      specify('starts with the 2nd of January') { is_expected.to eq Time.new(2000, 1, 2, 12) }
    end
  end

  describe '#date_by_cell' do
    subject { described_class.date_by_cell(x, y, year: 2017) }

    context 'top left' do
      let(:x) { 0 }
      let(:y) { 0 }

      it { is_expected.to eq Time.new(2017, 1, 1, 12) }
    end

    context 'down left' do
      let(:x) { 6 }
      let(:y) { 0 }

      it { is_expected.to eq Time.new(2017, 1, 7, 12) }
    end

    context 'top right (full column)' do
      let(:x) { 0 }
      let(:y) { 51 }

      it { is_expected.to eq Time.new(2017, 12, 24, 12) }
    end

    context 'down right (full column)' do
      let(:x) { 6 }
      let(:y) { 51 }

      it { is_expected.to eq Time.new(2017, 12, 30, 12) }
    end
  end
end
