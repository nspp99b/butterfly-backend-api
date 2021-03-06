class Flap < ApplicationRecord
  belongs_to :user
  has_many :causing_relationships, class_name:  "Relationship", foreign_key: "cause_id"
  has_many :effects, through: :causing_relationships, source: :effect
  has_many :causedby_relationships, class_name:  "Relationship", foreign_key: "effect_id"
  has_many :causes, through: :causedby_relationships, source: :cause
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }

  def self.active_flaps
    Flap.all.where(active: true)
  end

  def has_no_effects
    self.effects.empty?
  end

  def has_no_causes
    self.causes.empty?
  end

  def flap_with_children
    all_effects = {flap: self}
    if self.has_no_effects
      all_effects[:effects] = nil
    else
      all_effects[:effects] = self.effects.map { |e| e.flap_with_children }
    end
    all_effects
  end

  def fx_count
    all_effects = [self.effects.count]
    self.effects.each do |e|
      if e.has_no_effects
        all_effects << 0
      else
        all_effects << e.fx_count
      end
    end
    all_effects.sum
  end

  def flap_with_ancestors
    all_causes = {flap: self}
    if self.has_no_causes
      all_causes[:causes] = nil
    else
      all_causes[:causes] = self.causes.map { |e| e.flap_with_ancestors }
    end
    all_causes
  end

  def cause_count
    all_causes = [self.causes.count]
    self.causes.each do |e|
      if e.has_no_causes
        all_causes << 0
      else
        all_causes << e.cause_count
      end
    end
    all_causes.sum
  end

end
