started_at = Time.zone.now - 7.days
User.find_each do |user|
  user_day_tasks_count = rand(1..DayTask.count)
  day_tasks = DayTask.limit(user_day_tasks_count)
  day_tasks.each_with_index do |day_task, index|
    user_task = UserTask.create!(day_task: day_task, user: user, started_at: started_at)
    if index < user_day_tasks_count - 1
      user_task.update_attributes(finished_at: started_at + 1.second)
    end
  end
  started_at += 2.seconds
end