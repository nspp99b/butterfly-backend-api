class ConnectionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :follower
  has_one :followed

  def follower
    object.follower.to_json
  end

  def followed
    object.followed.to_json
  end

end
