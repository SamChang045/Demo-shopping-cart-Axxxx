class Product < ApplicationRecord

  validates_presence_of :name, :description, :price
  mount_uploader :image, PhotoUploader

  belongs_to :category

  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :order_items

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

end
