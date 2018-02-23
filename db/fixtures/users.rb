(1..5).each do |number|
  User.create!(
    email: "test#{number}@email.com",
    password: 'qwerty',
    password_confirmation: 'qwerty'
  )
end