class AddIsAvailableForReview < ActiveRecord::Migration[5.1]
  def change
    change_table :courses do |t|
      t.boolean :is_available_for_review, default: false
    end
  end


end
