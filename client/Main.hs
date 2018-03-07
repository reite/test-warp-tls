{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Wai.Handler.Warp

import App


main :: IO ()
main = do
    putStrLn $ "Serving on port " ++ show port
    run port app
    where
        port = 80
