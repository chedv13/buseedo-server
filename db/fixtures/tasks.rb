require 'faker'

task_id = 1
Course.find_each do |course|
  serial_number = 1
  course.days.each do |day|
    4.times do
      tasks = Task.seed do |t|
        t.body = Faker::Lorem.paragraph(rand(2..5))
        t.day_id = day.id
        t.id = task_id
        t.name = Faker::Lorem.paragraph
        t.number_of_percentages = 25
        t.number_of_points = task_id
        t.serial_number = serial_number
      end
      serial_number += 1
      task_id += 1
      task = tasks[0]
      task.skills << Skill.order('RANDOM()').limit(3)
    end
  end
end
