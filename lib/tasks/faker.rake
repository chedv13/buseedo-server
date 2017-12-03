namespace :faker do
  task :load_test_data do
    `rake db:seed_fu FILTER=days,levels,skills`
    `rake db:seed_fu FILTER=users`
    `rake db:seed_fu FILTER=tasks_and_day_tasks`
    `rake db:seed_fu FILTER=user_tasks`
  end
end
