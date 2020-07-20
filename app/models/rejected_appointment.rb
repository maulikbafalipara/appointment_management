class RejectedAppointment < ApplicationRecord
  ## Associations
  belongs_to :doctor
  belongs_to :appointment
end
