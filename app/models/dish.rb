class Dish < ActiveRecord::Base
  belongs_to :food_service

  validates_presence_of :description
end
