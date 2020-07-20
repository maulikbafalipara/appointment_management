class AppointmentsController < ApplicationController
  before_action :check_patient, except: [:confirm_appointment]
  before_action :authenticate_patient!, only: [:new, :create, :cancel]
  before_action :authenticate_doctor!, only: [:confirm_appointment]

  def new
    @appointment = @patient.appointments.new
  end

  def create
    @appointment = @patient.appointments.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to patients_path }
        flash[:success] = "Appointment was successfully created."
      else
        format.html { render action: "new" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
        flash[:error] = "Please fill correct data."
      end
    end
  end

  ## Cancel appointment by patient
  def cancel
    appointment = current_patient.appointments.find_by(id: params[:id])
    unless appointment.blank?
      appointment.update(status: 'cancel')
    end
    redirect_to patients_path
  end

  private
  def check_patient
    @patient = Patient.find_by(id: params[:patient_id])
    redirect_to new_patient_session_path if @patient.blank?
  end

  def appointment_params
    params.require(:appointment).permit(:title, :speciality_id, :start_time, :end_time)
  end
end
