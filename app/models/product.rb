class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  has_many :firms, through: :interests
  has_many :purchase_interests
  has_many :recipes
  has_many :sale_interests

  attr_accessible :name, :description, :rubro, :user_id, :unit, :stock, :initial_stock, :type

  validates :name, presence: true

  scope :general, -> { where type: '' }

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

  def lowest_price_and_firm
    lowest_price = 0
    purchase_interests.each do |purchase_interest|
      lowest_price = [purchase_interest.price, purchase_interest.firm.id] if purchase_interest.price < lowest_price || lowest_price == 0
    end
    lowest_price
  end

  def highest_price_and_firm
    highest_price = 0
    purchase_interests.each do |purchase_interest|
      highest_price = [purchase_interest.price, purchase_interest.firm.id] if purchase_interest.price > highest_price
    end
    highest_price
  end
end
