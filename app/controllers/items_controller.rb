class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box 
  before_action :set_item, only: %i[ show edit update destroy mark uncheck ]
  before_action :set_tenant
  before_action :set_current_account
  
  def index
    @items = @box.items
  end

  def new
    @item = @box.items.new
  end

  def show
  end

  def mark 
    @item.update(using_by: current_user.id)
    redirect_to @box, notice: "You'r using this item"
  end

  def uncheck
    @item.update(using_by: nil)
    redirect_to @box, notice: "You're not using this item anymore"
  end

  def move
    boxes = @current_account.boxes.select(:id, :name).where.not(id: params[:box_id])
    @box_options = boxes.each.map{|box| [box.name, box.id]}
  end

  def create 
    @item = @box.items.build(item_params)
    respond_to do |format|
      if @item.save
        format.html{redirect_to @box, notice: "Item created succesfully"}
        format.js
      else
        format.html{redirect_to @box, alert: "Failed to create item"}
        format.js
      end
    end
  end

  def update
    @target_box = @current_account.boxes.find(params[:to_box])
    if @item.update(box_id: @target_box.id)
      redirect_to @box, notice: "Item moved to box #{@target_box.name}"
    end
  end

  private

  def set_item
    @item = @box.items.find(params[:id])
  end

  def set_box
    @box = Box.find(params[:box_id])
  end

  def item_params
    params.require(:item).permit(:description, :image, :using_by)
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
