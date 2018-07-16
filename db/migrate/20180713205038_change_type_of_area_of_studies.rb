class ChangeTypeOfAreaOfStudies < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.change :area_of_studies, :text
    end
  end
end
