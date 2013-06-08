class DashboardController < ApplicationController
  before_filter :require_authentication, except: [ :messages ]

  def index
    @upcoming_food_services = @current_event.food_services.upcoming.order('opens_at ASC').includes(:dishes).limit(2)
    @food_services_pending = @upcoming_food_services.empty? && @current_event.food_services.empty?
    @messages = Message.published.on_site.order('sort_priority ASC, published_at DESC')
  end

  def food_services
    @upcoming_food_services = @current_event.food_services.upcoming.order('opens_at ASC').includes(:dishes)
    @past_food_services = @current_event.food_services.past.order('opens_at DESC').includes(:dishes)
    @food_services_pending = @upcoming_food_services.empty? && @current_event.food_services.empty?
  end

  def messages
    @messages = Message.published.on_site.order('published_at DESC')

    respond_to do |format|
      format.atom { render layout: false }
    end
  end
end
