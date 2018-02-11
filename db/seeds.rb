admin_email = 'admin@buseedo.com'
unless AdminUser.exists?(email: admin_email)
  password = '8X1Q419z4eaBnyE'
  AdminUser.create!(
      email: admin_email,
      password: password,
      password_confirmation: password
  )
end