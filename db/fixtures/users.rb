(30..100).each do
  name = Faker::Name.name
  while User.exists?(name: name)
    name = Faker::Name.name
  end
  User.create!(
    avatar: URI.parse(Faker::Avatar.image).open,
    email: "test#{DateTime.now.strftime('%Q')}@email.com",
    name: name,
    password: 'qwerty',
    password_confirmation: 'qwerty'
  )
end