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
end
