class ConnectionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :follower
  has_one :followed

  # def follower
  #   object.follower
  # end
  #
  # def followed
  #   object.followed
  # end

end
