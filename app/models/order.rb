class Order < ApplicationRecord

  belongs_to :user
  has_many :order_items , dependent: :destroy
  has_many :payments
  validates_presence_of :name, :phone, :address
  
end
