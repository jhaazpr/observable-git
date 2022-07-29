{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Control.Monad
import Control.Monad.IO.Class
import Data.Aeson
import Data.Maybe (fromJust)
import Data.Monoid ((<>))
import Data.Text (Text)
import GHC.Generics
import Network.HTTP.Req
import qualified Data.ByteString.Char8 as B
import qualified Text.URI as URI

main :: IO ()
main = runReq defaultHttpConfig $ do
  let n :: Int
      n = 5
  bs <- req GET (https "httpbin.org" /: "bytes" /~ n) NoReqBody bsResponse mempty
  liftIO $ B.putStrLn (responseBody bs)

