class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :doctor
      t.references :patient
      t.references :speciality
      t.string     :title
      t.datetime   :start_time
      t.datetime   :end_time
      t.integer    :status, limit: 1, default: 1

      t.timestamps
    end
  end
end
