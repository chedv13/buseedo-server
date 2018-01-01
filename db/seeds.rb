admin_email = 'admin@buseedo.com'
unless AdminUser.exists?(email: admin_email)
  AdminUser.create!(
      email: 'admin@buseedo.com',
      password: '8X1Q419z4eaBnyE',
      password_confirmation: '8X1Q419z4eaBnyE'
  )
end