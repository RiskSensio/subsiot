class SimulateSensor
  @queue = :mqtt

  def self.perform(user, password, remaining_count, sensor_hash)
    MQTT::Client.connect('mqtt.relayr.io', port: 1883, username: user, password: password) do |client|

      sensor_hash[:temperature] = 7.0 + 20 * rand unless sensor_hash.key?(:temperature)
      sensor_hash[:temperature] +=  0.1 * rand - 0.05
      sensor_hash[:temperature] = 0.0 if sensor_hash[:temperature] < 0.0

      sensor_hash[:humidity] = 40.0 * rand unless sensor_hash.key?(:humidity)
      sensor_hash[:humidity] += rand - 0.5
      sensor_hash[:humidity] = 0.0 if sensor_hash[:humidity] < 0.0

      if sensor_hash.key?(:motion) && sensor_hash[:motion]
        # 50% change of quake continuing
        sensor_hash[:motion] = rand * 100 > 50
      else
        # 5% change of quake starting
        sensor_hash[:motion] = rand * 100 > 95
      end

      if sensor_hash[:motion]
        sensor_hash[:vibration] = 750.0 + 500.0 * rand
      else
        sensor_hash[:vibration] = 20.0 * rand
      end

      publish_array = [
        {
          meaning: 'motion',
          value: sensor_hash[:motion]
        },

        {
          meaning: 'name',
          value: user
        },

        {
          meaning: 'vibration',
          value: sensor_hash[:vibration]
        },

        {
          meaning: 'temperature',
          value: sensor_hash[:temperature]
        },

        {
          meaning: 'humidity',
          value: sensor_hash[:humidity]
        }
      ]

      topic = "/v1/#{user}/data"
      payload = JSON.generate(publish_array)
      sleep(0.2)
      client.publish(topic, payload)

      Resque.enqueue(SimulateSensor, user, password, remaining_count - 1, sensor_hash) unless remaining_count <= 0
    end
  end

  def self.start
    # Kill any old jobs
    Resque.redis.del "queue:mqtt"
    # Simulate estimote sensors
    Resque.enqueue(SimulateSensor, 'fa2bb0ad-7610-4eaa-b0ca-10a3bcec1767', '7eLjm5NYB9De', 1000, {})
    Resque.enqueue(SimulateSensor, 'b3f3ce5b-770c-408d-9536-36c0599f4f7d', 'IpjPtR0cq69A', 1000, {})
    Resque.enqueue(SimulateSensor, '818ec1c6-6c0f-4faf-84e4-57036d53d55e', 'MbCm0I7rwkAA', 1000, {})
    Resque.enqueue(SimulateSensor, '7f7f055a-7e7c-4cb6-8de1-404bd905fd81', 'qzHw3lxvdYb2', 1000, {})
    Resque.enqueue(SimulateSensor, 'e63c9313-f038-4e2b-a5ea-87d6f22df9fd', 'i0hAVD7LC0xh', 1000, {})
    Resque.enqueue(SimulateSensor, '7e5045b1-3bdd-49f2-8a8f-24740ca931b0', '6rf4Uqg1YM6q', 1000, {})
    Resque.enqueue(SimulateSensor, '277e930c-4d8d-4bf3-bcff-beddafd51647', 'Ncj9sI1spoqr', 1000, {})
    Resque.enqueue(SimulateSensor, '1a0674b8-b48b-42b3-9d09-4e06e7fdd83f', 'r9TZwh6iLm_f', 1000, {})

    # Simulate real sensors
    Resque.enqueue(SimulateSensor, '452411b1-6b68-4fa6-b9f2-7c5d0b7b7c2d', 'C4a4C4UWYtPj', 1000, {})
    Resque.enqueue(SimulateSensor, 'ec20c6ef-2deb-487e-a09b-963ec2147fc9', '6MLoX3xEQ.AI', 1000, {})
  end
end

