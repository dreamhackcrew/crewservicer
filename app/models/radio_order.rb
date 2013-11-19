class RadioOrder < ActiveRecord::Base
  belongs_to :event
  has_many :radio_loans

  accepts_nested_attributes_for :radio_loans, allow_destroy: true

  validates_presence_of :description, :pickup_time, :return_time, :remote_speakers,
                        :remote_speakers_picked_up, :remote_speakers_returned,
                        :earpieces, :earpieces_picked_up, :earpieces_returned,
                        :headsets, :headsets_picked_up, :headsets_returned
  validate :return_after_pickup

  def earpieces_currently
    earpieces_picked_up - earpieces_returned
  end

  def remote_speakers_currently
    remote_speakers_picked_up - remote_speakers_returned
  end

  def headsets_currently
    headsets_picked_up - headsets_returned
  end

  private

  def return_after_pickup
    if return_time.present? && pickup_time.present? && return_time < pickup_time
      errors.add(:return_time, :must_be_after_pickup)
    end
  end
end
