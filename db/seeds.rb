# Create default admin user
admin_email = 'admin@buseedo.com'
unless AdminUser.exists?(email: admin_email)
  password = '8X1Q419z4eaBnyE'
  AdminUser.create!(
    email: admin_email,
    password: password,
    password_confirmation: password
  )
end

# Create default level for user
Level.create!(number: 1, required_number_of_points: 0)