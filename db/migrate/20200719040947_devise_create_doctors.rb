# frozen_string_literal: true

class DeviseCreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Personal information
      t.references :speciality
      t.string     :full_name
      t.string     :clinic_name
      t.string     :phone
      t.time       :start_time
      t.time       :end_time

      t.timestamps null: false
    end

    add_index :doctors, :email,                unique: true
    add_index :doctors, :reset_password_token, unique: true
  end
end
