class Card < ApplicationRecord
  belongs_to :cover
  belongs_to :location
end
