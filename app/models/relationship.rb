class Relationship < ApplicationRecord
  belongs_to :cause, class_name: "Flap"
  belongs_to :effect, class_name: "Flap"
  validates :cause_id, presence: true
  validates :effect_id, presence: true  
end
