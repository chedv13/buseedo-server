class AddStartedAtToUserDays < ActiveRecord::Migration[5.1]
  def change
    change_table :user_days do |t|
      t.datetime :started_at, null: false
    end
  end
end
