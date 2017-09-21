class AddAdditionalColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :name
      t.boolean :gender

      t.belongs_to :level, index: true
    end
  end
end
