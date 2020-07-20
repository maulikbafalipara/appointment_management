class Appointment < ApplicationRecord

  ## Associations
  belongs_to :doctor, optional: true
  belongs_to :patient
  belongs_to :speciality
  has_many   :rejected_appointments

  ## Enum for status
  enum status: { pending: 1, confirm: 2, complete: 3, cancel: 4 }

  ## Validations
  validates_presence_of :title, :speciality_id, :start_time, :end_time
  validate :validate_start_time_and_end_time, on: :create
  validate :check_availability, on: :create

  ## Scope
  scope :pending, -> { where(status: 'pending') }
  scope :complete, -> { where(status: 'complete') }
  scope :confirm, -> { where(status: 'confirm') }

  ## callbacks
  after_create_commit :set_notification_job

  def can_cancellable?
    status != 'cancel' && created_at+1.hour >= DateTime.current
  end

  # private

  def validate_start_time_and_end_time
    if start_time < DateTime.now
      errors.add :start_time, "invalid, please select future date or time."
    end

    if start_time >= end_time
      errors.add :end_time, "must be after start date."
    end
  end

  def check_availability
    appointments = Appointment.find_by_sql("SELECT * FROM appointments as appt WHERE appt.patient_id = #{patient_id} AND NOT ( GREATEST('#{start_time}','#{end_time}') < appt.start_time OR LEAST('#{start_time}','#{end_time}') > appt.end_time ) ")
    if appointments.any?
      errors.add(:patient_id, "already has an appointment. Try booking for other timeslots.")
    end
  end

  def set_notification_job
    # Resque.enqueue_at((self.start_time-1.hour), AppointmentNotificationJob, self.id)
    AppointmentNotificationMailer.upcoming_appointment(id).deliver_later(wait_until: start_time-1.hour)
  end
end
