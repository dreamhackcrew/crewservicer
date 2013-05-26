class Admin::RadioLoansController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_radio_order
  before_filter :set_radio_loan

  def show
  end

  def bind_radio
    serial_number = params[:radio_serial_number].upcase if params[:radio_serial_number]

    ActiveRecord::Base.transaction do
      @radio = Radio.find_or_create_by_serial_number(serial_number)

      @radio_loan.radio = @radio

      @radio_loan.save || (raise ActiveRecord::Rollback)
    end

    if @radio_loan.errors.size > 0
      render action: :show
    else
      redirect_to admin_radio_order_path(@radio_order)
    end
  end

  protected

  def set_radio_order
    @radio_order = RadioOrder.find(params[:radio_order_id])

    render_not_found if @radio_order.nil?
  end

  def set_radio_loan
    @radio_loan = RadioLoan.find(params[:id])

    render_not_found if @radio_loan.nil? || @radio_loan.radio_order_id != @radio_order.id
  end
end