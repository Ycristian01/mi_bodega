class BoxsController < ApplicationController

  def index
    @boxes = account.boxes.all
  end
  
end
