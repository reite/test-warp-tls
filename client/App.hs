{-# LANGUAGE DataKinds, TypeOperators, OverloadedStrings, MultiParamTypeClasses #-}

module App where

import Servant
import Servant.API
import Data.Proxy
import Data.Text (Text)
import qualified Data.ByteString.Lazy as ByteString
import Data.ByteString.Lazy (ByteString)
import Network.HTTP.Media ((//), (/:))
import Data.Aeson
import Control.Monad.IO.Class

data HTML

instance Accept HTML where
   contentType _ = "text" // "html" /: ("charset", "utf-8")

instance MimeRender HTML ByteString where
    mimeRender _ = id


type Api = Get '[HTML] ByteString


apiProxy :: Proxy Api
apiProxy = Proxy



apiServer :: Server Api
apiServer = liftIO $ ByteString.readFile "public/client.html"
    



app :: Application
app = serve apiProxy apiServer