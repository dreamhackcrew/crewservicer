class RadioLoan < ActiveRecord::Base
  belongs_to :radio_order
  belongs_to :radio

  validates_presence_of :description
  validate :has_radio_when_picked_up
  validate :radio_not_overused

  def status
    if returned_at?
      :returned
    elsif picked_up_at?
      :picked_up
    elsif radio
      :prepared
    else
      :new
    end
  end

  def has_radio_when_picked_up
    if [ :picked_up, :returned ].include?(status) && radio.nil?
      errors.add(:radio_id, :required_when_picked_up)
    end
  end

  def radio_not_overused
    return if radio_id.nil?

    non_returned_loans = RadioLoan.where('id != ? AND radio_id = ? AND returned_at IS NULL', id, radio_id).count

    if non_returned_loans > 0
      errors.add(:radio_id, :already_in_use)
    end
  end
end
