User.find_each do |user|
  user.courses_for_education << Course.where(is_published: true).order('RANDOM()').limit(rand(3..8))
end