User.find_each do |user|
  user.courses << Course.where(is_published: true).order('RANDOM()').limit(5)
end