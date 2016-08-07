module NumberToWords
  WORDS = {
    0  => 'zero',
    1  => 'one',
    2  => 'two',
    3  => 'three',
    4  => 'four',
    5  => 'five',
    6  => 'six',
    7  => 'seven',
    8  => 'eight',
    9  => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen'
  }

  TENS = {
    2 => 'twenty',
    3 => 'thirty',
    4 => 'forty',
    5 => 'fifty',
    6 => 'sixty',
    7 => 'seventy',
    8 => 'eighty',
    9 => 'ninety'
  }

  SIZES  = [1_000_000_000_000_000_000,
            1_000_000_000_000_000,
            1_000_000_000_000,
            1_000_000_000,
            1_000_000,
            1000,
            100,
            1]

  LABELS = ['quintillion',
            'quadrillion',
            'trillion',
            'billion',
            'million',
            'thousand',
            'hundred',
            '']

  def self.word_for(n)
    return if n == 0
    return n if n.is_a?(String)

    dm = WORDS[n]
    return dm if dm

    whole = (n / 10)
    remain = (n % 10)

    w_1 = TENS[whole]
    return w_1 unless remain > 0

    w_2 = WORDS[remain]

    [w_1, w_2].join(' ')
  end

  def self.words_for(arr)
    s = Hash[LABELS.zip(arr)]

    sv = s.each_with_object({}) do |(k,v), hsh|
      w = word_for(v)
      hsh[k] = w if w
    end

    return if sv.empty?

    sv.map { |k,v| "#{v} #{k}".strip }
      .join(' ')
      .strip
  end

  def self.call(n)
    s = SIZES.map do |i, l|
      x = (n / i)
      n = (n % i)
      (x >= 100 ? call(x) : x)
    end

    words_for(s)
  end
end
