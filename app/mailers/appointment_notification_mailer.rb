class AppointmentNotificationMailer < ApplicationMailer
  def upcoming_appointment(appointment_id)
    @appointment = Appointment.find_by(id: appointment_id)

    unless @appointment.blank?
      @doctor_email  = @appointment.try(:doctor).try(:email)
      @patient = @appointment.patient

      mail(to: [@doctor_email, @patient.email], subject: "Upcoming appointment!")
    end
  end
end
