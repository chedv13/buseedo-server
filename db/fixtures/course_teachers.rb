Course.published.each do |c|
  c.teachers << User.where('id > 5').order('RANDOM()').limit(rand(1..3))
end