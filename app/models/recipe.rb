class Recipe < ActiveRecord::Base
  has_paper_trail

  has_many :components, dependent: :destroy

  belongs_to :product

  attr_accessible :name, :description, :product_id

  validates_presence_of :name

  def to_s
    name
  end
end
