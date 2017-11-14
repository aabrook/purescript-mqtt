"use strict";

function noop() {}

exports.mqtt = function(importers) {
  return function(config) {
    return function() {
      const mqtt = require('mqtt')
      const onConnect = importers.onConnect || noop
      const onMessage = importers.onMessage || noop
      const subscriptions = importers.subscriptions || []
      const client = mqtt.connect(config)

      client.on('connect', function(err) { onConnect(err ? err.message : '') })
      client.on('message', function(topic, message){ onMessage(topic + '', message + '') })
      client.subscribe(subscriptions)
    }
  }
}
