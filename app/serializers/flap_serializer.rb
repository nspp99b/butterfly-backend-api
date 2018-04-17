class FlapSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :content, :created_at, :fxc
  belongs_to :user
  has_many :effects

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
      object.user
    else
      {id: object.user.id, name:"--", image: "http://oakdome.com/k5/cartoons/cartoon-gallery/images/butterfly.png"}
    end
  end

end


# def to_json
#   user = self.user.to_json
#   userId = self.user.id
#   fx = self.fx_count
#   if self.effects.size > 0
#     effects = self.effects.map {|e| e.to_json}
#   else
#     effects = []
#   end
#   if self.active
#     { id: self.id, user: user, content: self.content, created_at: time_ago_in_words(self.created_at) + ' ago', fx_count: fx, effects: effects }
#   else
#     { id: self.id, user: {id: userId, name:"--"}, content: "flap deleted", created_at: time_ago_in_words(self.created_at) + ' ago', fx_count: fx, effects: effects }
#   end
# end
