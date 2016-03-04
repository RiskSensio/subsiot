require 'twitter'

class IndexController < ApplicationController
  def index
    SimulateSensor.start

    redirect_to page_path('candle')

   #  client = Twitter::REST::Client.new do |config|
   #   config.consumer_key = 'BLEAp7Hh1tvoR4lX20AGIrBn9'
   #   config.consumer_secret = 	'zB8dKrfTFmBkmTSpv1V74LkoUdSK6UrR2adoGjYP3YgTvi3eKb'
   #   config.access_token = '703567729215848448-QuCIS5Mg07O063wNRdRh3FSILNZv8qr'
   #   config.access_token_secret = 'rLwx2s8gp3qa16EJ4r45vQc7xfk1Roc8675aY6ljgpRGe'
   #  end

   # @list = client.home_timeline
  end
end
