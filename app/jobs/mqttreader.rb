# require 'rubygems'
# require 'mqtt'

class MqttReader
  @queue = :mqtt

  def self.perform(user, password)
    print(user)
    print(password)
    MQTT::Client.connect('mqtt.relayr.io', :port => 1883, :user => user, :password => password) do |client|
      # If you pass a block to the get method, then it will loop
      print("logged in")
      client.get('/v1/{ser}/#') do |topic,message|
        puts "#{topic}: #{message}"
      end
    end
  end
end





