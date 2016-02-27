class QueueJob
  @queue = :mqtt

  def self.perform(user, password)
    print(user)
    MQTT::Client.connect('mqtt.relayr.io', :port => 1883, :username => user, :password => password) do |client|
      # If you pass a block to the get method, then it will loop
      client.get("/v1/#{user}/#") do |topic,message|
        puts "#{topic}: #{message}"
      end
    end
  end
end
