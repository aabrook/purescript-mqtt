module MqttApp where

import Prelude hiding (apply)
import Control.Monad.Eff (Eff, kind Effect)
import Data.Array

foreign import data MQTT :: Effect
type MqttM e a = Eff (mqtt :: MQTT | e) a
type MqttConnection = {
  onMessage :: (String -> String -> String)
  , onConnect :: (String -> String)
  , subscription :: Array String
  }

foreign import mqtt :: forall e. (MqttConnection) -> Eff (mqtt :: MQTT | e) Unit

onConnect topic message = topic : ":" : message

