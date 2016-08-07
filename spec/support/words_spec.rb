shared_examples 'in words' do |range: , label: , x: |

  range.to_a.sample(300).each do |n|
    it "#{n} (#{label})" do
      prefix = to_words(n / x)
      suffix = to_words(n % x)

      expect(to_words(n)).to eq("#{prefix} #{label} #{suffix}".strip)
    end
  end
end
