class FlapSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :content, :created_at, :fxc, :user, :effects

  def content
    if object.active
      object.content
    else
      "flap deleted"
    end
  end

  def created_at
    time_ago_in_words(object.created_at) + ' ago'
  end

  def fxc
    object.fx_count
  end

  def user
    if object.active
      UserSerializer.new(object.user)
    else
      {id: object.user.id, name:"--", image: "http://oakdome.com/k5/cartoons/cartoon-gallery/images/butterfly.png"}
    end
  end

  def effects
    if object.effects.size > 0
      efx = object.effects.map {|e| FlapSerializer.new(e)}
    else
      efx = []
    end
    efx
  end

end
