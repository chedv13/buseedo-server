first_level_id = Level.first.id
[20, 50, 100, 250, 500].each do |required_number_of_points|
  number = first_level_id + 1
  Level.seed do |l|
    l.id = number
    l.number = number
    l.required_number_of_points = required_number_of_points
  end
end