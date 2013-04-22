class EventsController < ApplicationController
  before_filter :require_administrator_privileges

  def index
    @events = Event.descending_dates
  end

  def import
    Event.create_all_from_cco_events(CrewCorner::Event.all)

    redirect_to action: :index
  end
end
