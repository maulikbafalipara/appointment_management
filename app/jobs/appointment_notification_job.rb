class AppointmentNotificationJob < ApplicationJob
  queue_as :default

  def self.perform(appointment_id)
    AppointmentNotificationMailer.upcoming_appointment(appointment_id).deliver
  end
end
