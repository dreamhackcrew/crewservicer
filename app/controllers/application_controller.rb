class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate
  before_filter :set_current_event

  protected

  def set_current_event
    @current_event = Event.active.order('start ASC').first
  end

  def authenticate
    if session[:person_id]
      @current_person = Person.find(session[:person_id])
      @cco_access_token = OAuth::AccessToken.from_hash(
        CrewCornerOauth.consumer,
        oauth_token: @current_person.cco_access_token,
        oauth_token_secret: @current_person.cco_access_token_secret
      )
    end
  end

  def require_administrator_privileges
    if @current_person.nil? || !@current_person.administrator?
      render_not_found
    end
  end

  def require_authentication
    if @current_person.nil?
      session[:login_return_path] = request.fullpath
      render 'sessions/new', status: 403
    end
  end

  def render_not_found
    render 'errors/not_found', status: 404
  end
end
