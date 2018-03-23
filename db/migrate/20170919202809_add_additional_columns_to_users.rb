class AddAdditionalColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.belongs_to :level, index: true, null: false
    end
  end
end
