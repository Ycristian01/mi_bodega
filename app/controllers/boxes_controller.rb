class BoxesController < ApplicationController
  before_action :authenticate_user!
  def index
    @boxes = Box.all
  end

  def new
    @box = Box.new
  end

  def show
  end

  def create 
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
