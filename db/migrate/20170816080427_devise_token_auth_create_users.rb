class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      ## Additional user Info
      t.boolean :gender
      t.boolean :is_first_filling_passed, default: false, null: false
      t.date :birth_date
      t.integer :current_number_of_points, default: 0, null: false
      t.integer :year_of_ending_of_educational_institution
      t.string :academic_degree
      t.string :area_of_studies, array: true
      t.string :country
      t.string :current_job
      t.string :dream_job
      t.string :educational_institution
      t.string :email
      t.string :hobby
      t.string :name

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, [:uid, :provider], unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
