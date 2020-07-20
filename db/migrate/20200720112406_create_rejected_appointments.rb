class CreateRejectedAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :rejected_appointments do |t|
      t.references :appointment
      t.references :doctor

      t.timestamps
    end
  end
end
