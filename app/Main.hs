{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Control.Monad
import Control.Monad.IO.Class
import Data.Aeson
import Data.Maybe (fromJust)
import Data.Monoid ((<>))
import Data.Text (Text, pack, unpack)
import GHC.Generics
import Network.HTTP.Req
import qualified Data.ByteString.Char8 as B
import qualified Text.URI as URI

import Secret (url, notebookName)

directory :: String
directory = "notebooks/"

filepath :: String
filepath = directory ++ unpack notebookName

main :: IO ()
main = runReq defaultHttpConfig $ do
  bs <- req GET url NoReqBody bsResponse mempty
  -- liftIO $ B.putStrLn (responseBody bs)
  liftIO $ B.writeFile filepath (responseBody bs)

