class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box 
  before_action :set_item, only: %i[ show edit update destroy mark uncheck ]
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
    if @item.update(item_params)
      redirect_to @box
      flash[:notice] = "item was successfully updated." 
    else
      redirect_to @box
      flash[:notice] = "item was no updated." 
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
  
end
