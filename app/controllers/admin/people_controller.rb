require 'upc_code'

class Admin::PeopleController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_query, only: :search
  before_filter :set_cco_user, only: [ :show, :update ]

  def index
    @people = Person.order('administrator DESC, username ASC').all
  end

  def show
    @event_info = CrewCorner::EventInfo.find(params[:id], @current_event.cco_id, access_token: @cco_access_token)
    @person = Person.find_or_update_by_cco_user(@cco_user)
  end

  def update
    @person = Person.find_or_update_by_cco_user(@cco_user)
    @person.update_attributes(params[:person])

    if @person.save
      redirect_to admin_person_path(@person)
    else
      @event_info = CrewCorner::EventInfo.find(params[:id], @current_event.cco_id, access_token: @cco_access_token)
      render action: :show
    end
  end

  def search
    case @query
    when Integer
      user = CrewCorner::User.find(@query, access_token: @cco_access_token)

      unless user.nil?
        redirect_to action: :show, id: @query
      else
        @users = []
      end
    when String
      @users = CrewCorner::User.search(@query, access_token: @cco_access_token)
    end
  end

  private

  def set_query
    @query = params[:q]
    @query = (@query.length == 12 ? UpcCode.new(@query) : @query).to_i if @query =~ /^\d+$/
  end

  def set_cco_user
    @cco_user = CrewCorner::User.find(params[:id], access_token: @cco_access_token)

    render_not_found if @cco_user.nil?
  end
end
