class Admin::RadioOrdersController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_radio_order, except: [ :index, :new, :create ]
  before_filter :set_pickup_radio_loans, only: :equipment_pickup
  before_filter :set_return_radio_loans, only: :equipment_return

  def index
    @radio_orders = @current_event.radio_orders.order('pickup_time ASC, description ASC')
    @radio_loan_counts = @current_event.radio_orders.includes(:radio_loans).references(:radio_loans).group('radio_orders.id').count('radio_loans.id')
    @prepared_radio_loan_counts = @current_event.radio_orders.includes(:radio_loans).references(:radio_loans)
      .where('radio_loans.radio_id IS NOT NULL').group('radio_orders.id').count('radio_loans.id')
    @picked_up_radio_loan_counts = @current_event.radio_orders.includes(:radio_loans).references(:radio_loans)
      .where('radio_loans.picked_up_at IS NOT NULL AND radio_loans.returned_at IS NULL').group('radio_orders.id').count('radio_loans.id')
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

  def delivery_note
    render layout: false
  end

  def equipment_pickup
  end

  def equipment_return
  end

  def pickup_equipment
    @radio_order.earpieces_picked_up += params[:earpieces].to_i
    @radio_order.remote_speakers_picked_up += params[:remote_speakers].to_i
    @radio_order.headsets_picked_up += params[:headsets].to_i
    @radio_order.charging_stations_picked_up += params[:charging_stations].to_i

    unless @radio_order.save
      set_pickup_radio_loans
      render action: :equipment_pickup
      return
    end

    if params[:radio_loan_ids].present?
      RadioLoan.find(params[:radio_loan_ids]).each do |radio_loan|
        next if radio_loan.radio_order_id != @radio_order.id

        radio_loan.picked_up_at = Time.now
        radio_loan.save
      end
    end

    redirect_to admin_radio_order_path(@radio_order)
  end

  def return_equipment
    @radio_order.earpieces_picked_up -= params[:earpieces].to_i
    @radio_order.remote_speakers_picked_up -= params[:remote_speakers].to_i
    @radio_order.headsets_picked_up -= params[:headsets].to_i
    @radio_order.charging_stations_picked_up -= params[:charging_stations].to_i

    unless @radio_order.save
      set_return_radio_loans
      render action: :equipment_return
      return
    end

    if params[:radio_loan_ids].present?
      RadioLoan.find(params[:radio_loan_ids]).each do |radio_loan|
        next if radio_loan.radio_order_id != @radio_order.id

        radio_loan.returned_at = Time.now
        radio_loan.save
      end
    end

    redirect_to admin_radio_order_path(@radio_order)
  end

  private

  def set_radio_order
    @radio_order = RadioOrder.includes(:radio_loans => [ :radio ]).order('radio_loans.description').find(params[:id])
  end

  def set_pickup_radio_loans
    @prepared_radio_loans = @radio_order.radio_loans.where('radio_id IS NOT NULL AND picked_up_at IS NULL')
    @other_radio_loans = @radio_order.radio_loans.where('radio_id IS NULL OR (radio_id IS NOT NULL AND picked_up_at IS NOT NULL)')
  end

  def set_return_radio_loans
    @picked_up_radio_loans = @radio_order.radio_loans.where('picked_up_at IS NOT NULL AND returned_at IS NULL')
    @other_radio_loans = @radio_order.radio_loans.where('picked_up_at IS NULL OR (picked_up_at IS NOT NULL AND returned_at IS NOT NULL)')
  end

  def radio_order_params
    params.require(:radio_order).permit(
      :description,
      :pickup_time,
      :return_time,
      :remote_speakers,
      :earpieces,
      :headsets,
      :charging_stations,
      { radio_loans_attributes: [ :id, :_destroy, :description ] }
    )
  end
end
