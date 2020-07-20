class PatientsController < ApplicationController
  before_action :authenticate_patient!

  def index
    @appointments = current_patient.appointments.includes(:doctor, :speciality)
  end

  def doctors
    @doctors = Doctor.includes(:speciality).all
  end
end
