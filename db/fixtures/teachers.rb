(1..rand(5..10)).each do
  user_count = User.count
  name = Faker::Name.name
  while User.exists?(name: name)
    name = Faker::Name.name
  end
  User.create!(
    avatar: URI.parse(Faker::Avatar.image).open,
    description: Faker::Lorem.paragraph(rand(1..10)),
    email: "test#{user_count + 1}@email.com",
    name: name,
    password: 'qwerty',
    password_confirmation: 'qwerty'
  )
end
