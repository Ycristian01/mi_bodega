class BoxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box, only: %i[ show edit update destroy ]
  def index
    @boxes = current_tenant.boxes
  end

  def new
    @box = Box.new
    @boxes = current_tenant.boxes
  end

  def show
    @items = @box.items
  end

  def create 
    @boxes = current_tenant.boxes
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

end
