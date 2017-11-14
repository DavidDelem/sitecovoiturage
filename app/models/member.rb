class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Lien member -> trajet
  has_many :trajets, dependent: :destroy
  # Lien covoiturage -> member
  has_many :reservations
  has_many :trajets_passager, through: :reservations, source: :trajet, dependent: :destroy
end
