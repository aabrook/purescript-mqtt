"use strict";

function noop() {}

const config = {
  'host': process.env.MQTT_HOST,
  'port': process.env.MQTT_PORT,
  'username': process.env.MQTT_USER,
  'password': process.env.MQTT_PASS
}

exports.mqtt = function(importers) {
    return function() {
      const mqtt = require('mqtt')
      const onConnect = importers.onConnect || noop
      const onMessage = importers.onMessage || noop
      const subscriptions = importers.subscriptions || []
      const client = mqtt.connect(config)

      client.on('connect', function(connection, err) {
        console.log(onConnect(err ? err.message : ''))
      })
      client.on('message', function(topic, message){
        console.log(onMessage(topic + '')(message + ''))
      })
      client.subscribe(subscriptions)
    }
}
