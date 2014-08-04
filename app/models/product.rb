class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  has_many :components
  has_many :purchase_interests
  has_many :sale_interests
  has_many :firms, through: :interests

  attr_accessible :name, :description, :rubro, :user_id, :unit, :stock, :initial_stock, :type

  validates :name, presence: true

  def type_to_show
    case self
      when CustomProduct then 'Producto Fabricado'
      when RawMaterial then 'Materia Prima'
      else 'Producto general'
    end
  end

  def self.types_for_select
    [['Producto general', nil], ['Producto fabricado', 'CustomProduct'], ['Materia prima', 'RawMaterial']]
  end

  def self.products_for_select
    Product.all.map{ |x| [x.name, x.id]}
  end

  def to_s
    name
  end
end
