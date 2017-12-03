(1..5).each do |number|
  user = User.seed do |u|
    u.current_number_of_points = 0
    u.id = number
    u.email = "test#{number}@email.com"
    u.level_id = 1
  end[0]
  user.update_attribute(:password, 'qwerty')
end