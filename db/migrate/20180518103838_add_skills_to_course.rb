class AddSkillsToCourse < ActiveRecord::Migration[5.1]
  def change
    change_table :courses do |t|
      t.jsonb :skills
    end
  end
end
