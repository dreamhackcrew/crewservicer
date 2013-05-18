class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    @next_food_service = @current_event.food_services.upcoming.order('opens_at ASC').includes(:dishes).first
  end
end