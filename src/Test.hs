module Test(
  main) where
import System.IO.Encoding hiding (print)
import Data.Encoding.GB18030
import Data.Encoding.UTF8
import Data.Encoding
import Prelude hiding(putStrLn,readFile)
main::IO()
main=do
  let ?enc = UTF8
  putStrLn "你好"
  putStrLn (take 1 "你好" )
  print "你好"
  f <- readFile "utf-8.txt"
  print f
  putStrLn f
  let ?enc = GB18030
  g <-  readFile "gb2312.txt"
  let ?enc = UTF8
  putStrLn g
