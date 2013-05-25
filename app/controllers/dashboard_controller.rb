class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    @upcoming_food_services = @current_event.food_services.upcoming.order('opens_at ASC').includes(:dishes).limit(2)
  end

  def food_services
    @upcoming_food_services = @current_event.food_services.upcoming.order('opens_at ASC').includes(:dishes)
    @past_food_services = @current_event.food_services.past.order('opens_at DESC').includes(:dishes)
  end
end
