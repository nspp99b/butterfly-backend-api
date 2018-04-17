class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :image
  has_many :following
  has_many :followers
  has_many :flaps

  def followers
    object.followers.map { |f| f.id }
  end

  def following
    object.following.map { |f| f.id }
  end

end
