# TODO: Здесь бы по хорошему применить реально сколько дней в году
(1..365).each do |number|
  Day.seed do |d|
    d.id = number
    d.number = number
  end
end