class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string, :default => "http://oakdome.com/k5/cartoons/cartoon-gallery/images/butterfly.png"
  end
end
