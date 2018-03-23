class CreateSkillTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_tasks do |t|
      t.belongs_to :skill, index: true, null: false
      t.belongs_to :task, index: true, null: false

      t.timestamps
    end
  end
end
