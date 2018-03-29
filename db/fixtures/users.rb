(1..5).each do |number|
  name = Faker::Name.name
  while User.exists?(name: name)
    name = Faker::Name.name
  end
  User.create!(
    avatar: URI.parse(Faker::Avatar.image).open,
    email: "test#{number}@email.com",
    name: name,
    password: 'qwerty',
    password_confirmation: 'qwerty'
  )
end