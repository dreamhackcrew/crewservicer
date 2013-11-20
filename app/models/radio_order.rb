class RadioOrder < ActiveRecord::Base
  belongs_to :event
  has_many :radio_loans

  accepts_nested_attributes_for :radio_loans, allow_destroy: true

  validates_presence_of :description, :pickup_time, :return_time, :remote_speakers,
                        :remote_speakers_picked_up, :earpieces, :earpieces_picked_up,
                        :headsets, :headsets_picked_up
  validate :return_after_pickup, :earpieces_not_exceeded, :remote_speakers_not_exceeded,
           :headsets_not_exceeded


  def earpieces_available
    earpieces - earpieces_picked_up
  end

  def remote_speakers_available
    remote_speakers - remote_speakers_picked_up
  end

  def headsets_available
    headsets - headsets_picked_up
  end

  private

  def return_after_pickup
    if return_time.present? && pickup_time.present? && return_time < pickup_time
      errors.add(:return_time, :must_be_after_pickup)
    end
  end

  def earpieces_not_exceeded
    errors.add(:earpieces_picked_up, :must_not_exceed_available) if earpieces_available < 0
  end

  def remote_speakers_not_exceeded
    errors.add(:remote_speakers_picked_up, :must_not_exceed_available) if remote_speakers_available < 0
  end

  def headsets_not_exceeded
    errors.add(:headsets_picked_up, :must_not_exceed_available) if headsets_available < 0
  end
end
