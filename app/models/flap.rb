class Flap < ApplicationRecord
  belongs_to :user
  has_many :causing_relationships, class_name:  "Relationship", foreign_key: "cause_id"
  has_many :effects, through: :causing_relationships, source: :effect
  has_many :causedby_relationships, class_name:  "Relationship", foreign_key: "effect_id"
  has_many :causes, through: :causedby_relationships, source: :cause
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end
