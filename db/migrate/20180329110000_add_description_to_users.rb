class AddDescriptionToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.text :description
    end
  end
end
