namespace :faker do
  task :load_test_data do
    p '-- courses,levels,skills'
    `rake db:seed_fu FILTER=courses,levels,skills`
    p '-- days'
    `rake db:seed_fu FILTER=days`
    p '-- tasks'
    `rake db:seed_fu FILTER=tasks`
    p '-- users'
    `rake db:seed_fu FILTER=users`
    p '-- teachers'
    `rake db:seed_fu FILTER=teachers`
    p '-- course_teachers'
    `rake db:seed_fu FILTER=course_teachers`
    p '-- course_users'
    `rake db:seed_fu FILTER=course_users`
  end

  task :update_final_number_of_points_from_tasks => :environment do
    Course.find_each do |course|
      final_number_of_points = 0
      course.days.each do |d|
        d.tasks.each do |t|
          final_number_of_points += t.number_of_points
        end
      end
      course.final_number_of_points = final_number_of_points
      course.save
    end
  end

  task :create_new_user_tasks => :environment do
    time_now = Time.zone.now - 1.year
    CourseUser.find_each do |course_user|
      days = course_user.course.days.limit(rand(10..75))
      days.each do |day|
        day.tasks.each do |task|
          finished_at = time_now + rand(5..20).seconds
          user_task = UserTask.find_by(course_user: course_user, task: task)
          user_task.intervals.create!(started_at: time_now, finished_at: finished_at)
          user_task.decisions.create!(body: Faker::Lorem.paragraph(rand(2..8)))
          user_task.is_completed = true
          user_task.save
          time_now = finished_at
        end
      end
    end
  end
end
