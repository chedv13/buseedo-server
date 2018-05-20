Course.find_each do |course|
  number_of_points = 1
  course.days.each do |day|
    (1..4).each do |serial_number|
      task = Task.create!(
        body: Faker::Lorem.paragraph(rand(2..5)),
        day: day,
        is_published: true,
        name: Faker::Lorem.paragraph,
        number_of_percentages: 25,
        number_of_points: number_of_points,
        serial_number: serial_number
      )
      task.skills << Skill.order('RANDOM()').limit(rand(1..3))
    end
  end
end
