class QueueJob
  @queue = :mqtt

  def self.perform
    MQTT::Client.connect('mqtt://sqkspljc:3NX3rRyb0Bl0@m20.cloudmqtt.com:13119') do |client|
      # If you pass a block to the get method, then it will loop
      client.get('#') do |topic,message|
        puts "#{topic}: #{message}"
      end
    end
  end
end
