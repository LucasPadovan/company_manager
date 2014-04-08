class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  has_many :product_histories, dependent: :destroy
  has_many :sale_histories, dependent: :destroy
  has_many :components

  attr_accessible :name, :description, :rubro, :user_id, :unit, :stock, :initial_stock, :type

  validates :name, presence: true

  def type
    case self
      when CustomProduct then 'Producto Fabricado'
      when RawMaterial then 'Materia Prima'
      else 'Producto general'
    end
  end

  def self.types_for_select
    [['Sin tipo especial', ''], ['Producto fabricado', 'CustomProduct'], ['Materia prima', 'RawMaterial']]
  end
end
