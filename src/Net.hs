{-# LANGUAGE OverloadedStrings #-}
module Net where

import Network.HTTP
import Network.Stream
--import Network.Browser
import Parser(baseUrl,getUrl,fetchFtp)
import Data.Encoding.GB18030
import Data.Encoding.UTF8
import Data.Encoding(encodeString,decodeString)
--import System.IO.Streams (InputStream, OutputStream, stdout)
--import Network.Http.Client
--import qualified System.IO.Streams as Streams
--import qualified Data.ByteString as S
--import Data.ByteString.Char8 (pack,unpack)

open :: String -> IO String
--open url = undefined
open url = do
    r <- simpleHTTP (getRequest url)
    body <- getResponseBody r
    let a = decodeString GB18030 body
    return a

openwith :: String -> (String -> a) -> IO a
openwith url f = do
    html <- open url
    return (f html)

spider :: String -> (String -> a) -> a
spider html f = f html

test startUrl= do
    html <- open startUrl
    let urls = spider html fetchFtp
    mapM_ putStrLn urls