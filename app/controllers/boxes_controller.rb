class BoxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box, only: %i[ show edit update destroy ]
  before_action :set_tenant
  before_action :set_current_account

  def index
    @boxes = Box.all
  end

  def new
    @box = Box.new
    @boxes = Box.all
  end

  def show
    @items = @box.items.order(:created_at)
  end

  def create 
    @boxes = @current_account.boxes
    @box = Box.new(box_params)
    if @box.save
      redirect_to boxes_path 
      flash[:notice] = "box was successfully created"      
    else
      render 'new'     
    end
  end

  private

  def set_box
    @box = Box.find(params[:id])
  end

  def box_params
    params.require(:box).permit(:name)
  end

  def set_tenant
    account = Account.find(current_user&.current_tenant_id)
    set_current_tenant(account)
  rescue
    redirect_to accounts_path
  end

  def set_current_account
    @current_account = Account.find_by(id: current_user.current_tenant_id)
  end
end
