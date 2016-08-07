require 'spec_helper'
require 'number_to_words'

describe NumberToWords do
  def to_words(n)
    described_class.call(n)
  end

  describe '.call' do
    (1..19).each do |n|
      it "#{n} - #{described_class::WORDS[n]}" do
        expect(to_words(n)).to eq(described_class::WORDS[n])
      end
    end

    (20..99).step(10).each do |n|
      it "#{n} - #{described_class::TENS[n / 10]}" do
        expect(to_words(n)).to eq(described_class::TENS[n / 10])
      end

      (1..9).each do |j|
        it "#{n + j}" do
          prefix = to_words(n)
          suffix = to_words(j)
          v      = n + j

          expect(to_words(v)).to eq("#{prefix} #{suffix}")
        end
      end
    end

    it_behaves_like 'in words', range: 100.upto(999).lazy,
                                label: 'hundred',
                                x: 100

    it_behaves_like 'in words', range: 1_000.upto(999_999).lazy,
                                label: 'thousand',
                                x: 1_000

    it_behaves_like 'in words', range: 1_000_000.upto(4_999_999).lazy,
                                label: 'million',
                                x: 1_000_000

    it_behaves_like 'in words', range: 5_000_000.upto(9_999_999).lazy,
                                label: 'million',
                                x: 1_000_000

    it_behaves_like 'in words', range: 1_000_000_000.upto(1_000_000_999).lazy,
                                label: 'billion',
                                x: 1_000_000_000

    it_behaves_like 'in words', range: 2_000_000_000.upto(2_000_000_999).lazy,
                                label: 'billion',
                                x: 1_000_000_000

    it_behaves_like 'in words', range: 3_000_000_000.upto(3_000_000_999).lazy,
                                label: 'billion',
                                x: 1_000_000_000

    it_behaves_like 'in words', range: (4_000_000_000..4_000_000_999).lazy,
                                label: 'billion',
                                x: 1_000_000_000

    it_behaves_like 'in words', range: (1_000_000_000_000..1_000_500_000_000).lazy,
                                label: 'trillion',
                                x: 1_000_000_000_000

    it_behaves_like 'in words', range: (1_000_000_000_000_000..1_000_000_500_000_000).lazy,
                                label: 'quadrillion',
                                x: 1_000_000_000_000_000

    it_behaves_like 'in words', range: (1_000_000_000_000_000_000..1_000_000_000_500_000_000).lazy,
                                label: 'quintillion',
                                x: 1_000_000_000_000_000_000
  end
end
