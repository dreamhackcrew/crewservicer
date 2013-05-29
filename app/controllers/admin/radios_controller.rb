class Admin::RadiosController < ApplicationController
  def index
    @active_radio_loans = RadioLoan.joins(:radio_order).includes(:radio_order, :radio).where('radio_orders.event_id = ? AND radio_loans.radio_id IS NOT NULL AND radio_loans.returned_at IS NULL', @current_event).order('radio_orders.description, radio_loans.description')
    @returned_radio_loans = RadioLoan.joins(:radio_order).includes(:radio_order, :radio).where('radio_orders.event_id = ? AND radio_loans.returned_at IS NOT NULL', @current_event).order('radio_orders.description, radio_loans.description')
  end
end
