module MqttApp where

import Prelude hiding (apply)
import Control.Monad.Eff (Eff, kind Effect)
import Data.Array

foreign import data MQTT :: Effect
type MqttConnection = {
  onMessage :: (String -> String -> String)
  , onConnect :: (String -> String)
  , subscriptions :: Array String
}

foreign import mqtt :: forall e. (MqttConnection) -> Eff (mqtt :: MQTT | e) Unit

onConnect "" = "Connected"
onConnect error = error

onMessage topic message = topic <> " with message of " <> message
subscriptions = ["#"]

setup = { onMessage: onMessage
   , onConnect: onConnect
   , subscriptions: subscriptions
   }

main::forall e. Eff (mqtt::MQTT | e) Unit
main = mqtt setup

