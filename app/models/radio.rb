class Radio < ActiveRecord::Base
  has_many :radio_loans

  validates_presence_of :serial_number
end