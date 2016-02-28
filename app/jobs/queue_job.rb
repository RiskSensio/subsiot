require 'twitter'
# require 'pry'
require 'json'

class QueueJob
  @queue = :mqtt

  def self.perform(user, password)
    print(user)
    MQTT::Client.connect('mqtt.relayr.io', :port => 1883, :username => user, :password => password) do |client|
      # If you pass a block to the get method, then it will loop
      client.get("/v1/#{user}/#") do |topic,message|

       hash = JSON.parse(message)

       vibration_level = hash.find{|x| x["meaning"]=="vibration"}["value"]

       puts "#{topic}: #{message}"

       twitter = Twitter::REST::Client.new do |config|
         config.consumer_key = 'BLEAp7Hh1tvoR4lX20AGIrBn9'
         config.consumer_secret =   'zB8dKrfTFmBkmTSpv1V74LkoUdSK6UrR2adoGjYP3YgTvi3eKb'
         config.access_token = '703567729215848448-QuCIS5Mg07O063wNRdRh3FSILNZv8qr'
         config.access_token_secret = 'rLwx2s8gp3qa16EJ4r45vQc7xfk1Roc8675aY6ljgpRGe'
       end

       case
         when vibration_level >= 1000
           twitter.update("RED ALERT! wendychanhk your MyAvivaHome is shaking! AvivaUKSupport")
         when vibration_level >= 800
           twitter.update("ORANGE ALERT! wendychanhk your MyAvivaHome is shaking! AvivaUKSupport")
         when vibration_level >= 600
           twitter.update("YELLOW ALERT! wendychanhk your MyAvivaHome is shaking! AvivaUKSupport")
       end

     end
   end
 end
end
