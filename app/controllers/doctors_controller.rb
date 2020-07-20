class DoctorsController < ApplicationController
  before_action :authenticate_doctor!

  def index
    @rejected_appointments = Appointment.joins(:rejected_appointments).includes(:patient).where(rejected_appointments: {doctor_id: current_doctor.id})
    @pending_appointments = Appointment.pending.includes(:rejected_appointments, :patient).where(speciality_id: current_doctor.speciality_id).where(rejected_appointments: {id: nil})
    @appointments = current_doctor.appointments.includes(:patient).group_by{ |a| a.status }
  end

  ## reject appointment by doctor
  def reject
    current_doctor.reject_appointment!(params[:appointment_id])
    redirect_to doctors_path
  end

  ## confirm appointment by doctor
  def confirm
    appointment = Appointment.pending.find_by(id: params[:appointment_id])
    redirect_to doctors_path if appointment.blank?
    pre_appointments = Appointment.find_by_sql("SELECT * FROM appointments as appt WHERE appt.doctor_id = #{current_doctor.id} AND NOT ( GREATEST('#{appointment.start_time}','#{appointment.end_time}') < appt.start_time OR LEAST('#{appointment.start_time}','#{appointment.end_time}') > appt.end_time ) ")
    is_confirmed = false
    unless pre_appointments.any? && appointment.blank?
      appointment.update(status: 'confirm', doctor_id: current_doctor.id)
      is_confirmed = true
    end

    respond_to do |format|
      if is_confirmed
        format.html { redirect_to doctors_path }
        flash[:success] = "Appointment was successfully confirmed."
      else
        format.html { redirect_to doctors_path }
        flash[:error] = "you have already appointment with same time."
      end
    end
  end
end
