require 'upc_code'

class PeopleController < ApplicationController
  before_filter :require_authentication

  def index
    @current_user = CrewCorner::User.current(access_token: @cco_access_token)
  end

  def search
    @query = params[:q]

    unless @query.nil?
      if @query =~ /^\d+$/
        id = @query.length == 12 ? UpcCode.new(@query) : @query
        user = CrewCorner::User.find(id.to_i, access_token: @cco_access_token)

        @users = user.nil? ? [] : [ user ]
      else
        @users = CrewCorner::User.search(@query, access_token: @cco_access_token)
      end
    end
  end
end
