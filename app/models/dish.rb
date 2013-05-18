class Dish < ActiveRecord::Base
  belongs_to :food_service

  attr_accessible :description, :vegetarian, :lactose_free, :gluten_free

  validates_presence_of :description
end