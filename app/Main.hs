{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Data.Text.IO qualified as T
import Data.Text qualified as T
import MyLib qualified (someFunc)
import System.Environment
import System.IO (hFlush, stdout)
import Control.Exception (catch, IOException)
import System.IO.Error (isEOFError)
import Prelude hiding (readFile)

scanner :: T.Text -> IO ()
scanner src = do
  putStr $ show src <> "  << "
  MyLib.someFunc

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> repl
    filename : _ -> do
      readFile filename

readFile :: String -> IO ()
readFile src = do
  content <- T.readFile src
  scanner content

repl :: IO ()
repl = do
  putStr "> "
  hFlush stdout
  continue <- (do
    line <- T.getLine
    scanner line
    return True) `catch` handler
  if continue then repl else return ()
  where
    handler :: IOException -> IO Bool
    handler e
      | isEOFError e = do
          putStrLn "\nbye"
          return False
      | otherwise = ioError e
