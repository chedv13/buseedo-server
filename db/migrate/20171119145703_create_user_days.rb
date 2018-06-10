class CreateUserDays < ActiveRecord::Migration[5.1]
  def change
    create_table :user_days do |t|
      t.boolean :is_completed, default: false, null: false

      t.belongs_to :day, index: true
      t.belongs_to :course_user, index: true

      t.timestamps
    end
  end
end
