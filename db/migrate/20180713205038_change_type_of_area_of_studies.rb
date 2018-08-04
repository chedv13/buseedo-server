class ChangeTypeOfAreaOfStudies < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :area_of_studies, :text
  end

  def down
    change_column :users, :area_of_studies, :string, array: true
  end
end
