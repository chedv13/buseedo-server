class CreateSkillsTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :skills_tasks do |t|
      t.belongs_to :skill, index: true, null: false
      t.belongs_to :task, index: true, null: false
    end
  end
end
