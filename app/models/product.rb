class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  has_many :product_histories, dependent: :destroy
  has_many :sale_histories, dependent: :destroy
  has_many :components

  attr_accessible :name, :description, :rubro, :user_id, :unit, :stock, :initial_stock, :type

end
