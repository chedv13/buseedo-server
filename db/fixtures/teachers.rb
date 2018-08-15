(1..rand(30..40)).each do
  name = Faker::Name.name
  while User.exists?(name: name)
    name = Faker::Name.name
  end
  User.create!(
    avatar: URI.parse(Faker::Avatar.image).open,
    description: Faker::Lorem.paragraph(rand(1..10)),
    email: "test#{DateTime.now.strftime('%Q')}@email.com",
    name: name,
    password: 'qwerty',
    password_confirmation: 'qwerty'
  )
  sleep(0.5)
end
