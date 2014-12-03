class ClientOrder < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :firm

  # has_many :lines

  attr_accessible :completed, :details, :deliver_in, :external_code, :firm_id, :number, :place, :received, :status, :user_id

  validates :number, presence: true

  after_initialize :generate_number
  before_create    :create_as_open

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

  private
    def generate_number
      seed = Date.today.year.to_i + 100000
      id   = ClientOrder.last.try(:id) || 0
      self.number = seed + id
    end

    def create_as_open
      self.status = STATUSES[:open]
    end
end
