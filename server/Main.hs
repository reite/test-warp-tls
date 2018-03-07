{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.Cors
import Network.Wai.Logger (withStdoutLogger)
import Network.Wai.Handler.WarpTLS

import App


main :: IO ()
main = do
    putStrLn $ "Serving with TLS on port " ++ show port
    withStdoutLogger $ \aplogger -> do
        let settings = setPort port $ setLogger aplogger defaultSettings
        runTLS theTlsSettings settings (corsMiddleware app)
    where
        port = 443
        theTlsSettings = tlsSettings "/etc/letsencrypt/live/warp.qubit.no/cert.pem" "/etc/letsencrypt/live/warp.qubit.no/privkey.pem" 

        corsMiddleware = cors (const $ Just simpleCorsResourcePolicy { 
            corsOrigins        = Just (["http://localhost", "http://localhost:3000", "https://warp-tls-test.firebaseapp.com"], False),
            corsRequestHeaders = "authorization":simpleHeaders,
            corsMethods        = "PUT":simpleMethods
        })
