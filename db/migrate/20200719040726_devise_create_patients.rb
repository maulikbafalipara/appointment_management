# frozen_string_literal: true

class DeviseCreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Personal information
      t.string  :username, null: false, default: ""
      t.string  :full_name
      t.integer :sex
      t.date    :dob

      t.timestamps null: false
    end

    add_index :patients, :email,                unique: true
    add_index :patients, :reset_password_token, unique: true
    add_index :patients, :username,             unique: true
  end
end
