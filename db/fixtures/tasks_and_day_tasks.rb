require 'faker'

number_of_points = 1
Day.find_each do |day|
  (1..3).each do |number|
    random_paragraphs_number = rand(1..4)
    tasks = Task.seed do |t|
      t.body = Faker::Lorem.paragraph(random_paragraphs_number)
      t.id = number_of_points
      t.name = Faker::Lorem.paragraph
      t.number_of_points = number_of_points
    end
    number_of_points += 1
    task = tasks[0]
    task.update_attribute(:is_default, true) if Task.count == 1
    DayTask.seed do |dt|
      dt.id = number_of_points
      dt.day_id = day.id
      dt.task_id = task.id
      dt.number_of_percentages = number == 3 ? 40 : 30
    end
  end
end