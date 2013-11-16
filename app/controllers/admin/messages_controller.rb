class Admin::MessagesController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :set_message, only: [ :show, :update, :publish, :destroy, :restore ]

  def index
    @active_messages = Message.active.order('sort_priority ASC, published_at DESC')
    @deleted_messages = Message.deleted.order('deleted_at DESC')
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.event = @current_event

    if @message.save
      redirect_to [ :admin, @message ]
    else
      render action: :new
    end
  end

  def update
    @message.update_attributes(message_params)

    if @message.save
      redirect_to [ :admin, @message ]
    else
      render action: :show
    end
  end

  def sort
    params[:messages].each_value do |message_params|
      message = Message.find(message_params['id'])
      message.sort_priority = message_params['sort_priority']
      message.save
    end

    redirect_to admin_messages_path
  end

  def publish
    @message.published_at = Time.now
    @message.save

    redirect_to [ :admin, @message ]
  end

  def destroy
    @message.deleted_at = Time.now
    @message.save

    redirect_to [ :admin, @message ]
  end

  def restore
    @message.published_at = nil
    @message.deleted_at = nil
    @message.save

    redirect_to [ :admin, @message ]
  end

  protected

  def set_message
    @message = Message.find(params[:id])

    unless @message
      render_not_found
    end
  end

  def message_params
    params.require(:message).permit(
      :published_at, :deleted_at, :headline, :text, :on_site, :on_info_screen, :sort_priority
    )
  end
end
