class Speciality < ApplicationRecord
  ## Associations
  has_many :appointments
  has_many :doctors
end
