class RadioOrder < ActiveRecord::Base
  belongs_to :event
  has_many :radio_loans

  accepts_nested_attributes_for :radio_loans, allow_destroy: true

  validates_presence_of :description
end
