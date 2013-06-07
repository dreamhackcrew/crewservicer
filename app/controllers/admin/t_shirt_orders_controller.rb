class Admin::TShirtOrdersController < ApplicationController
  before_filter :require_administrator_privileges

  def index
    @crew_t_shirt_orders = @current_event.t_shirt_orders.where(model: :crew).joins(:person).includes(:person).order('people.username ASC')
    @gift_t_shirt_orders = @current_event.t_shirt_orders.where(model: :gift).joins(:person).includes(:person).order('people.username ASC')
  end
end
