module Main (main) where

import System.Environment
import qualified MyLib (someFunc)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> MyLib.someFunc
    _ -> print args
