class Flap < ApplicationRecord
  belongs_to :user
  has_many :causing_relationships, class_name:  "Relationship", foreign_key: "cause_id"
  has_many :effects, through: :causing_relationships, source: :effect
  has_many :causedby_relationships, class_name:  "Relationship", foreign_key: "effect_id"
  has_many :causes, through: :causedby_relationships, source: :cause
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }

  def has_no_effects
    self.effects.empty?
  end

  def has_no_causes
    self.causes.empty?
  end

  def create_effects_tree
    all_effects = {flap: self}
    if self.has_no_effects
      all_effects[:effects] = nil
    else
      all_effects[:effects] = self.effects.map { |e| e.create_effects_tree }
    end
    all_effects
  end

  def create_causes_tree
    all_causes = {flap: self}
    if self.has_no_causes
      all_causes[:causes] = nil
    else
      all_causes[:causes] = self.causes.map { |e| e.create_causes_tree }
    end
    all_causes
  end

end
