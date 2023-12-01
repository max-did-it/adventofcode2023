DIGITS = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9"
}

REGEX = /(#{DIGITS.keys.join("|")}|[0-9])/

def get_digit(line, inx)
  return line[inx] if ("0".."9").cover? line[inx]

  _word, digit = DIGITS.find do |word, digit|
    next if line[inx] != word[0]

    substr = line[inx...(inx + word.length)]
    substr == word
  end

  digit
end

sum = 0
File.open("input", "r") do |f|
  while (l = f.readline)
    first_digit = get_digit l, l.index(REGEX)
    last_digit = get_digit l, l.rindex(REGEX)
    number = (first_digit + last_digit).to_i

    sum += number
  end
rescue EOFError
  puts sum
end
