class Order < ApplicationRecord

  belongs_to :user
  has_many :order_items , dependent: :destroy
  validates_presence_of :name, :phone, :address
  
end
