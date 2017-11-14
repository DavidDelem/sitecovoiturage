class Trajet < ApplicationRecord
  # has_many :members
  # belongs_to :conducteur, class_name: 'Member', foreign_key: :conducteur_id
  # Lien member -> trajet
  belongs_to :member
  # Lien covoiturage -> trajet
  has_many :reservations, dependent: :destroy
  has_many :members, through: :reservations
end
