require 'upc_code'

class Admin::PeopleController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_query, only: :search

  def index
    @current_user = CrewCorner::User.current(access_token: @cco_access_token)
  end

  def show
    @cco_user = CrewCorner::User.find(params[:id], access_token: @cco_access_token)
    @event_info = CrewCorner::EventInfo.find(params[:id], @current_event.cco_id, access_token: @cco_access_token)
    @person = Person.find_by_cco_id(params[:id])
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
end
