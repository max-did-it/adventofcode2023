REGEX = /^(Game ([0-9]+)):(( [0-9]+ (red|green|blue),?)+;?)+$/

MAXIMUMS = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}
def possible_sum(l)
  game_id, game = l.split(":")
  possible_game = game.split(";").map do |set_game|
    h = set_game.split(",").map(&:strip).map { _1.split(" ").reverse }.to_h
    set_result = %w[red green blue].all? do |color|
      next true unless h[color]
      h[color].to_i <= MAXIMUMS[color]
    end
    set_result
  end
  possible_game.all? ? game_id.split(" ").last.to_i : 0
end

def power_sum(l)
  _, game = l.split(":")
  minimums = {
    "red" => 0,
    "blue" => 0,
    "green" => 0
  }
  game.split(";").each do |set_game|
    h = set_game.split(",").map(&:strip).map { _1.split(" ").reverse }.to_h
    %w[red green blue].each do |color|
      minimums[color] = h[color].to_i if minimums[color].to_i < h[color].to_i
    end
  end
  minimums.values.inject(1) { _1 * _2 }
end

File.open("input", "r") do |f|
  ids_sum = 0
  power_sum = 0
  while (l = f.readline)
    ids_sum += possible_sum(l)
    power_sum += power_sum(l)
  end
rescue EOFError
  puts "IDS SUM = #{ids_sum}"
  puts "POWER SUM = #{power_sum}"
end
