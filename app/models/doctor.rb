class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Associations
  has_many   :appointments
  has_many   :patients, through: :appointments
  has_many   :rejected_appointments
  belongs_to :speciality

  def reject_appointment!(appointment_id)
    appointment = Appointment.pending.find_by(id: appointment_id)
    return if appointment.blank?

    rejected_appointments.create(appointment_id: appointment.id)
  end
end
