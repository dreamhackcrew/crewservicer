class Admin::RadioOrdersController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_radio_order, except: [ :index, :new, :create ]

  def index
    @radio_orders = @current_event.radio_orders.order('description ASC')
  end

  def show
  end

  def new
    @radio_order = RadioOrder.new
  end

  def create
    @radio_order = RadioOrder.new(radio_order_params)
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
    if @radio_order.update_attributes(radio_order_params)
      redirect_to edit_admin_radio_order_path(@radio_order)
    else
      render action: :edit
    end
  end

  def next_loan_status
    if params[:pickup_radio_loan_ids]
      RadioLoan.find(params[:pickup_radio_loan_ids]).each do |radio_loan|
        next if radio_loan.radio_order_id != @radio_order.id

        radio_loan.picked_up_at = Time.now
        radio_loan.save
      end
    end

    if params[:return_radio_loan_ids]
      RadioLoan.find(params[:return_radio_loan_ids]).each do |radio_loan|
        next if radio_loan.radio_order_id != @radio_order.id

        radio_loan.returned_at = Time.now
        radio_loan.save
      end
    end

    redirect_to admin_radio_order_path(@radio_order)
  end

  private

  def set_radio_order
    @radio_order = RadioOrder.includes(:radio_loans => [ :radio ]).find(params[:id])
  end

  def radio_order_params
    params.require(:radio_order).permit(
      :description,
      :pickup_time,
      :return_time,
      :remote_speakers,
      :earpieces,
      :headsets,
      { radio_loans_attributes: [ :id, :_destroy, :description ] }
    )
  end
end
