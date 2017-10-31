class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Lien member -> trajet
  has_many :trajets
  # Lien covoiturage -> member
  has_many :covoiturages
  has_many :trajets, through: :covoiturages
end
