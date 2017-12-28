require 'faker'

number_of_points = 1
Day.find_each do |day|
  (0..2).each do |number|
    number_of_points += 1
    random_paragraphs_number = rand(1..4)
    tasks = Task.seed do |t|
      t.body = Faker::Lorem.paragraph(random_paragraphs_number)
      t.id = number_of_points
      t.number_of_points = number_of_points
    end
    task = tasks[0]
    if Task.count == 1
      task.update_attribute(:is_default, true)
    end
    DayTask.seed do |dt|
      dt.id = number_of_points
      dt.day_id = day.id
      dt.task_id = task.id
      dt.number_of_percentages = number == 3 ? 40 : 30
    end
  end
end