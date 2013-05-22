class Admin::EventsController < ApplicationController
  before_filter :require_administrator_privileges

  def index
    @events = Event.order('start DESC')
  end

  def import
    Event.create_all_from_cco_events(CrewCorner::Event.all)

    redirect_to action: :index
  end
end
