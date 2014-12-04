class Order < ActiveRecord::Base
  # todo: al realizar una nueva order, realizar un interest entre la firma y los productos pedidos

  has_paper_trail

  belongs_to :user
  belongs_to :firm

  has_many :items

  attr_accessible :completed, :details, :deliver_in, :external_code, :firm_id, :number, :place, :received, :requester, :requester_area, :status, :user_id

  validates :number, presence: true

  before_create :create_as_open

  scope :open, -> { where status: STATUSES[:open] }

  STATUSES = {
               open:      'Iniciada',
               cancelled: 'Cancelada',
               completed: 'Completada',
               traveling: 'En viaje'
             }

  def to_s
    number.to_s
  end

  def cancell!
    self.status    = STATUSES[:cancelled]
    self.cancelled = Time.now
    self.save
  end

  def generate_number
    seed = Date.today.year.to_i + 100000
    id   = Order.last.try(:id) || 0
    self.number = seed + id
  end

  private
    def create_as_open
      self.status = STATUSES[:open]
    end
end
