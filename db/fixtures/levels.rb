[20, 50, 100, 250].each_with_index do |required_number_of_points, idx|
  number = idx + 1
  Level.seed do |l|
    l.id = number
    l.number = number
    l.required_number_of_points = required_number_of_points
  end
end