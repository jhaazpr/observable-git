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

import Secret (usernameUrl, notebookNames, makeSaveFilepath)

downloadNotebook :: Text -> IO ()
downloadNotebook name =
    let notebookUrl = usernameUrl /: name
        saveFilepath = makeSaveFilepath $ unpack name
    in runReq defaultHttpConfig $ do
        bs <- req GET notebookUrl NoReqBody bsResponse mempty
        liftIO $ B.writeFile saveFilepath (responseBody bs)

addAndCommit :: IO ()
addAndCommit = putStrLn "todo"

main :: IO ()
main = do
    downloads <- sequence_ $ map downloadNotebook notebookNames
    addAndCommit

