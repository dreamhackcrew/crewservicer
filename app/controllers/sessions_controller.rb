class SessionsController < ApplicationController
  before_filter :create_request_token, only: :create
  before_filter :create_access_token, only: :callback

  def new

  end

  def create
    session[:cco_request_token] = @request_token.token
    session[:cco_request_token_secret] = @request_token.secret

    redirect_to @request_token.authorize_url(oauth_callback: oauth_callback_url)
  end

  def destroy
    session.delete(:person_id)

    redirect_to dashboard_path
  end

  def callback
    cco_user = CrewCorner::User.current(access_token: @access_token)

    person = Person.find_or_update_by_cco_user(cco_user)

    person.cco_access_token = @access_token.token
    person.cco_access_token_secret = @access_token.secret
    person.save

    session[:person_id] = person.id

    redirect_to session.delete(:login_return_path) || :root
  end

  private

  def create_request_token
    @request_token = CrewCornerOauth.get_request_token(oauth_callback_url)

    if @request_token.token.nil?
      render nothing: true
    end
  end

  def create_access_token
    request_token = OAuth::RequestToken.from_hash(
      CrewCornerOauth.consumer,
      oauth_token: session.delete(:cco_request_token),
      oauth_token_secret: session.delete(:cco_request_token_secret)
    )

    @access_token = CrewCornerOauth.get_access_token(request_token, params['oauth_verifier'])
  end
end
