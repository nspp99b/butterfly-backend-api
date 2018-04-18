class ConnectionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :follower
  has_one :followed

end
