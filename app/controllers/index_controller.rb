require 'twitter'

class IndexController < ApplicationController
  def index
    # Start sensor similator
    SimulateSensor.start
    # Redirect ro demo page
    redirect_to page_path('demo')
  end
end
