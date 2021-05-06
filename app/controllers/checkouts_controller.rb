require 'stripe'  
class CheckoutsController < ApplicationController
  before_action :authenticate_user!
end
  