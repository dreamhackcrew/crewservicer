class RadioLoan < ActiveRecord::Base
  belongs_to :radio_order
  belongs_to :radio

  attr_accessible :description, :remote_speaker_accessory, :earpiece_accessory,
                  :headset_accessory, :pickup, :return
end