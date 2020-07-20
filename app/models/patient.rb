class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  ## Associations
  has_many :appointments

  ## Enum for sex
  enum sex: { male: 1, female: 2, transgender: 3 }

  ## Validations
  validates :username, uniqueness: true
end
