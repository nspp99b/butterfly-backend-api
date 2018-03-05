class User < ApplicationRecord
  has_many :flaps
  has_many :active_connections, class_name:  "Connection",
                                foreign_key: "follower_id"
  has_many :following, through: :active_connections, source: :followed
  has_many :passive_connections, class_name:  "Connection",
                                   foreign_key: "followed_id"
  has_many :followers, through: :passive_connections, source: :follower

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def to_json
    {
      id: self.id,
      name: self.name,
      email: self.email,
      following: self.following.map {|f| f.id},
      followers: self.followers.map {|f| f.id}
    }
  end

  def follow(other_user)
    self.following << other_user
  end

  def unfollow(other_user)
    self.following.delete(other_user)
  end

  def following?(other_user)
    self.following.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM connections WHERE follower_id = :user_id"
    Flap.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

end
