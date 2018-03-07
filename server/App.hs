{-# LANGUAGE DataKinds, TypeOperators, OverloadedStrings #-}

module App where

import Servant
import Data.Text (Text)
import Data.Aeson



type Api = "nocors" :> Get '[PlainText] Text
      :<|> "cors" :> Header "authorization" Text :> Get '[JSON] Value


apiProxy :: Proxy Api
apiProxy = Proxy



apiServer :: Server Api
apiServer = return "Hello world!"
       :<|> \_ -> return (String "Hello world!")



app :: Application
app = serve apiProxy apiServer