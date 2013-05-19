class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    @upcoming_food_services = @current_event.food_services.upcoming.order('opens_at ASC').includes(:dishes).limit(2)
  end
end
