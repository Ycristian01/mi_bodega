class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box 
  before_action :set_item, only: %i[ show edit update destroy ]
  def index
    @items = @box.items
  end

  def new
    @item = @box.items.new
  end

  def show
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

  private

  def set_item
    @item = @box.items.find(params[:id])
  end

  def set_box
    @box = Box.find(params[:box_id])
  end

  def item_params
    params.require(:item).permit(:description, :image)
  end
  
end
