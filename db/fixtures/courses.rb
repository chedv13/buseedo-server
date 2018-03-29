30.times do |i|
  Course.create!(
    background_image: URI(Faker::Avatar.image('my-own-slug', '500x500', 'jpg')).open,
    cover: URI(Faker::Avatar.image).open,
    description: Faker::Lorem.paragraph(rand(2..10)),
    is_published: rand < 0.5,
    name: Faker::Lorem.sentence,
    rating: i
  )
end
