class SimulateSensor
  @queue = :mqtt

  def self.perform(user, password, remaining_count, sensor_hash)
    MQTT::Client.connect('mqtt.relayr.io', port: 1883, username: user, password: password) do |client|
      sensor_hash['temperature'] = 7.0 + 20 * rand unless sensor_hash.key?('temperature')
      sensor_hash['temperature'] += 0.1 * rand - 0.05
      sensor_hash['temperature'] = 0.0 if sensor_hash['temperature'] < 0.0

      sensor_hash['humidity'] = 40.0 * rand unless sensor_hash.key?('humidity')
      sensor_hash['humidity'] += 3 * (rand - 0.5)
      sensor_hash['humidity'] = 0.0 if sensor_hash['humidity'] < 0.0

      if sensor_hash.key?('motion') && sensor_hash['motion']
        # 75% change of quake continuing
        sensor_hash['motion'] = (rand * 100) > 25
      else
        # 5% change of quake starting
        sensor_hash['motion'] = (rand * 100) > 95
      end

      if sensor_hash['motion']
        sensor_hash['vibration'] = 750.0 + 500.0 * rand
      else
        sensor_hash['vibration'] = 20.0 * rand + 1.0
      end

      publish_array = [
        {
          meaning: 'motion',
          value: sensor_hash['motion']
        },

        {
          meaning: 'name',
          value: user
        },

        {
          meaning: 'vibration',
          value: sensor_hash['vibration']
        },

        {
          meaning: 'temperature',
          value: sensor_hash['temperature']
        },

        {
          meaning: 'humidity',
          value: sensor_hash['humidity']
        }
      ]

      topic = "/v1/#{user}/data"
      payload = JSON.generate(publish_array)
      sleep(0.2)
      client.publish(topic, payload)
      # Make sure the last job kills itself when we restart
      if Resque.size('mqtt') > 0
        Resque.enqueue(SimulateSensor, user, password, remaining_count - 1, sensor_hash) unless remaining_count <= 0
      end
    end
  end

  def self.start
    # Kill any old jobs
    Resque.redis.del 'queue:mqtt'
    # Give final job time to die
    sleep(5)
    # Simulate estimote sensors

    # westminster
    # 'clientId': 'T21fV+r1MScSwv2LcPnbvhA',
    # 'user':     'db57d5fa-bd4c-49c4-b0bf-62dc3e76ef84',
    # 'password': 'ictPDjoyQ6_e',
    Resque.enqueue(SimulateSensor, 'db57d5fa-bd4c-49c4-b0bf-62dc3e76ef84', 'ictPDjoyQ6_e', 1000, {})

    # fca
    # 'clientId': 'T/d2BcyojR4+xZfD8ThJ6sg',
    # 'user':     'fddd8173-2a23-478f-b165-f0fc4e127ab2',
    # 'password': 'xV40f2Xi.VAw',

    Resque.enqueue(SimulateSensor, 'fddd8173-2a23-478f-b165-f0fc4e127ab2', 'xV40f2Xi.VAw', 1000, {})

    # deutsche
    # 'clientId': 'TD/MqRGvYSq2+95MniH6AAw',
    # 'user':     '0ff32a44-6bd8-4aad-bef7-9327887e8003',
    # 'password': 'owNXJM4VPTE9',
    Resque.enqueue(SimulateSensor, '0ff32a44-6bd8-4aad-bef7-9327887e8003', 'owNXJM4VPTE9', 1000, {})

    # tfl
    # 'clientId': 'T6/9r5cFBQuioktFvn3wueg',
    # 'user':     'ebff6be5-c141-42e8-a892-d16f9f7c2e7a',
    # 'password': 'zpTsJLLGgl4N',
    Resque.enqueue(SimulateSensor, 'ebff6be5-c141-42e8-a892-d16f9f7c2e7a', 'zpTsJLLGgl4N', 1000, {})

    # britinsur
    # 'clientId': 'TqowrZDXySTmHmH06SPgU+A',
    # 'user':     'aa8c2b64-35f2-4939-8798-7d3a48f814f8',
    # 'password': 'NdCggrrzUZFf',
    Resque.enqueue(SimulateSensor, 'aa8c2b64-35f2-4939-8798-7d3a48f814f8', 'NdCggrrzUZFf', 1000, {})

    # hoxton
    # 'clientId': 'TgjQpYcH0QeWG+lTdFxOGlQ',
    # 'user':     '82342961-c1f4-41e5-86fa-54dd17138695',
    # 'password': 'tZiPC5QnGy8y',
    Resque.enqueue(SimulateSensor, '82342961-c1f4-41e5-86fa-54dd17138695', 'tZiPC5QnGy8y', 1000, {})

    # # Simulate real sensors
    # Resque.enqueue(SimulateSensor, '452411b1-6b68-4fa6-b9f2-7c5d0b7b7c2d', 'C4a4C4UWYtPj', 1000, {})
    # Resque.enqueue(SimulateSensor, 'ec20c6ef-2deb-487e-a09b-963ec2147fc9', '6MLoX3xEQ.AI', 1000, {})
  end
end

