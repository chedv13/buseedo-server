(1..365).each do |number|
  Day.seed do |d|
    d.id = number
    d.number = number
  end
end