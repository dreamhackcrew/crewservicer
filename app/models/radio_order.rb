class RadioOrder < ActiveRecord::Base
  belongs_to :event
  has_many :radio_loans

  attr_accessible :description, :radio_loans_attributes
  accepts_nested_attributes_for :radio_loans, allow_destroy: true
end