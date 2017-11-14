module MqttApp where

import Prelude hiding (apply)
import Control.Monad.Eff (Eff, kind Effect)

foreign import data MQTT :: Effect
type MqttConnection = {
  onMessage :: (String -> String -> String)
  , onConnect :: (String -> String)
  , subscriptions :: Array String
}

foreign import mqtt :: forall e. (MqttConnection) -> Eff (mqtt :: MQTT | e) Unit

onConnect :: String -> String
onConnect "" = "Connected"
onConnect error = error

onMessage :: String -> String -> String
onMessage topic message = topic <> " with message of " <> message

subscriptions :: Array String
subscriptions = ["#"]

setup :: MqttConnection
setup = { onMessage: onMessage
   , onConnect: onConnect
   , subscriptions: subscriptions
   }

main::forall e. Eff (mqtt::MQTT | e) Unit
main = mqtt setup

