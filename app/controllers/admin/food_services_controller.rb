class Admin::FoodServicesController < ApplicationController
  before_filter :require_administrator_privileges
  before_filter :find_food_service, only: [ :show, :update ]

  def index
    @food_services = @current_event.food_services.order('opens_at ASC').includes(:dishes)
  end

  def new
    @food_service = FoodService.new
  end

  def create
    @food_service = FoodService.new(params[:food_service])
    @food_service.event = @current_event

    if @food_service.save
      redirect_to [ :admin, @food_service ]
    else
      render action: :new
    end
  end

  def show
  end

  def update
    @food_service.update_attributes(params[:food_service])

    if @food_service.save
      redirect_to [ :admin, @food_service ]
    else
      render action: :show
    end
  end

  private

  def find_food_service
    @food_service = FoodService.find(params[:id])
  end
end
