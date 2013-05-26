class Admin::RadioOrdersController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_radio_order, only: [ :show, :edit, :update ]

  def index
    @radio_orders = @current_event.radio_orders.order('description ASC').all
  end

  def show
  end

  def new
    @radio_order = RadioOrder.new
  end

  def create
    @radio_order = RadioOrder.new(params[:radio_order])
    @radio_order.event = @current_event

    if @radio_order.save
      redirect_to edit_admin_radio_order_path(@radio_order)
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @radio_order.update_attributes(params[:radio_order])
      redirect_to edit_admin_radio_order_path(@radio_order)
    else
      render action: :edit
    end
  end

  private

  def set_radio_order
    @radio_order = RadioOrder.includes(:radio_loans => [ :radio ]).find(params[:id])
  end
end