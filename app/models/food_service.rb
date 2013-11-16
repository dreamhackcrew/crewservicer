class FoodService < ActiveRecord::Base
  belongs_to :event
  has_many :dishes

  accepts_nested_attributes_for :dishes, allow_destroy: true

  validates_presence_of :opens_at, :closes_at, :event

  scope :upcoming, ->{ where("closes_at >= ?", Time.now) }
  scope :past, ->{ where("closes_at < ?", Time.now) }

  def open?
    opens_at <= Time.now && closes_at > Time.now
  end
end
