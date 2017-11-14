"use strict";

const noop = () => {}

exports.mqtt = (importers) => {
  return (config) => {
    return () => {
      const mqtt = require('mqtt')
      const { subscriptions = [], onConnect = noop, onMessage = noop } = importers
      const client = mqtt.connect(config)

      client.on('connect', ({ message = '' }) => onConnect(message))
      client.on('message', (topic, message) => onMessage(`${topic}`, `${message}`))
      client.subscribe(subscriptions)
    }
  }
}
