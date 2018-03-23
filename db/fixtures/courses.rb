30.times do |i|
  Course.create!(
    description: Faker::Lorem.paragraph(rand(2..10)),
    is_published: rand < 0.5,
    name: Faker::Lorem.sentence,
    rating: i
  )
end
