class Event < ActiveRecord::Base
  has_many :food_services
  has_many :radio_orders
  has_many :t_shirt_orders
  has_many :messages

  attr_accessible :cco_id, :name, :start, :end, :construction_start, :teardown_end, :active

  validates_uniqueness_of :cco_id
  validates_presence_of :name, :start, :end, :construction_start, :teardown_end
  validates_inclusion_of :active, in: [ true, false ]

  scope :active, where(active: true)

  def self.create_all_from_cco_events(cco_events)
    cco_events_hash = Hash[cco_events.map { |e| [e.id, e] }]

    existing_events = Event.find_all_by_cco_id(cco_events_hash.keys)
    events = []

    existing_events.each do |event|
      cco_event = cco_events_hash.delete(event.cco_id)

      event.update_attributes(converted_cco_event_attributes(cco_event))

      if event.save
        events << event
      else
        Rails.logger.info "Didn't update event for cco event with id #{new_cco_event.id} because it was invalid"
      end
    end

    cco_events_hash.each_value do |new_cco_event|
      new_event = Event.new(converted_cco_event_attributes(new_cco_event))

      if new_event.save
        events << new_event
      else
        Rails.logger.info "Didn't save new cco event with id #{new_cco_event.id} because it was invalid"
      end
    end

    events
  end

  private

  def self.converted_cco_event_attributes(cco_event)
    {
      cco_id: cco_event.id,
      name: cco_event.name,
      start: cco_event.start,
      end: cco_event.end,
      construction_start: cco_event.preparestart,
      teardown_end: cco_event.prepareend,
      active: cco_event.active
    }
  end
end
