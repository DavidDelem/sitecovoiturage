class Reservation < ApplicationRecord
  belongs_to :trajet
  belongs_to :member
end
