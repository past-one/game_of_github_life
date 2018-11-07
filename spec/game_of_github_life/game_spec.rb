# frozen_string_literal: true

RSpec.describe GameOfGithubLife::Game do
  describe '#neighbors' do
    subject { described_class.new(field).neighbors(x, y) }

    context 'all the same' do
      let(:field) do
        [
          [0, 0, 0],
          [0, 1, 0],
          [0, 0, 0],
        ]
      end

      let(:x) { 1 }
      let(:y) { 1 }

      it { is_expected.to eq [0] * 8 }
    end

    context 'different' do
      let(:field) do
        [
          [0, 1, 1],
          [0, 1, 1],
          [0, 0, 0],
        ]
      end

      let(:x) { 1 }
      let(:y) { 1 }

      it { is_expected.to eq [0, 1, 1, 0, 1, 0, 0, 0] }
    end

    context 'edge case' do
      let(:field) do
        [
          [0, 1, 1],
          [0, 1, 1],
          [0, 0, 0],
        ]
      end

      let(:x) { 0 }
      let(:y) { 0 }

      it { is_expected.to eq [1, 0, 1] }
    end

    context 'not squared field' do
      let(:field) do
        [
          [0, 1, 1],
          [0, 1, 1],
        ]
      end

      let(:x) { 1 }
      let(:y) { 0 }

      it { is_expected.to eq [0, 1, 1] }
    end
  end

  describe '#next' do
    subject { described_class.new(field).next }

    context 'underpopulation' do
      let(:field) do
        [
          [1, 0, 1],
          [0, 0, 0],
          [1, 0, 1],
        ]
      end

      it do
        result = [
          [0, 0, 0],
          [0, 0, 0],
          [0, 0, 0],
        ]
        is_expected.to eq result
      end
    end

    context 'overpopulation' do
      let(:field) do
        [
          [1, 1, 1],
          [1, 1, 1],
          [1, 1, 1],
        ]
      end

      it do
        result = [
          [1, 0, 1],
          [0, 0, 0],
          [1, 0, 1],
        ]
        is_expected.to eq result
      end
    end

    context 'nothing changes' do
      let(:field) do
        [
          [0, 0, 0, 0],
          [0, 1, 1, 0],
          [0, 1, 1, 0],
          [0, 0, 0, 0],
        ]
      end

      it do
        result = [
          [0, 0, 0, 0],
          [0, 1, 1, 0],
          [0, 1, 1, 0],
          [0, 0, 0, 0],
        ]
        is_expected.to eq result
      end
    end
  end

  describe '#field_footprint' do
    subject { described_class.field_footprint(field) }

    context 'empty field' do
      let(:field) do
        [
          [0, 0],
          [0, 0],
        ]
      end

      it { is_expected.to eq 0 }
    end

    context 'full field 3x3' do
      let(:field) do
        [
          [1, 1, 1],
          [1, 1, 1],
          [1, 1, 1],
        ]
      end

      it { is_expected.to eq 511 }
    end

    context '2x2 square in 4x4' do
      let(:field) do
        [
          [0, 0, 0, 0],
          [0, 1, 1, 0],
          [0, 1, 1, 0],
          [0, 0, 0, 0],
        ]
      end

      it { is_expected.to eq 1632 }
    end
  end

  describe '#ended?' do
    let(:game) { described_class.new(field) }

    context 'at the start' do
      let(:field) do
        [
          [0, 0, 0],
          [0, 1, 0],
          [0, 0, 0],
        ]
      end

      it { expect(game).not_to be_ended }

      context 'with empty field' do
        let(:field) do
          [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0],
          ]
        end

        it { expect(game).to be_ended }
      end
    end

    context 'all died' do
      let(:field) do
        [
          [0, 0, 0],
          [0, 1, 0],
          [0, 0, 0],
        ]
      end

      before { game.next }

      it { expect(game).to be_ended }
    end

    context 'nothing changes' do
      let(:field) do
        [
          [0, 0, 0, 0],
          [0, 1, 1, 0],
          [0, 1, 1, 0],
          [0, 0, 0, 0],
        ]
      end

      before { game.next }

      it { expect(game).to be_ended }
    end

    context 'repeating cycle of 1 step' do
      let(:field) do
        [
          [0, 1, 0],
          [0, 1, 0],
          [0, 1, 0],
        ]
      end

      before { 3.times { game.next } }

      it { expect(game).to be_ended }
    end
  end
end
