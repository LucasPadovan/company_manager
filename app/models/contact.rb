class Contact < ActiveRecord::Base
  has_paper_trail

  belongs_to :firm

  attr_accessible :name, :area, :details, :firm_id

  #validates_presence_of :name, :area, :details

  end
