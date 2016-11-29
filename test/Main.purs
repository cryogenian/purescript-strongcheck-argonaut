{-
Copyright 2015 SlamData, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-}

module Test.Main where

import Prelude

import Control.Monad.Eff.Console (log)

import Data.Argonaut (decodeJson, encodeJson)
import Data.Either (Either(..))

import Test.StrongCheck (SC, quickCheck, (===))
import Test.StrongCheck.Data.Argonaut (runArbJCursor, runArbJson)

main ∷ ∀ eff. SC eff Unit
main = do

  log "Check codecs for Json"
  quickCheck (runArbJson >>> \x -> Right x === decodeJson (encodeJson x))

  log "Check codecs for JCursor"
  quickCheck (runArbJCursor >>> \x -> Right x === decodeJson (encodeJson x))
