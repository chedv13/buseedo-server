class AddContinuedAtToCourseUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :course_users do |t|
      t.datetime :continued_at
    end
  end
end
