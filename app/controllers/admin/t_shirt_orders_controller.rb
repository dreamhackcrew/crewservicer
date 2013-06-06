class Admin::TShirtOrdersController < ApplicationController
  before_filter :require_administrator_privileges

  def index
    @crew_t_shirt_orders = @current_event.t_shirt_orders.where(model: :crew).includes(:person)
    @gift_t_shirt_orders = @current_event.t_shirt_orders.where(model: :gift).includes(:person)
  end
end
