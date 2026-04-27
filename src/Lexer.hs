{-# LANGUAGE OverloadedStrings #-}

module Lexer (someFunc) where

import Control.Monad ((>=>))
import Data.Text qualified as T
import Data.Text.IO qualified as T

someFunc :: IO ()
someFunc = putStrLn "someFunc"

data Token
  = TokNum Double
  | TokAdd
  | TokMul
  deriving (Show, Eq)

newtype Pos
  = Post Int
  deriving (Show, Eq)

data PosState = PosStete
  { pstateInput :: T.Text
  , pstateOffset :: Int
  , pstateSourcePos :: Pos
  }
  deriving (Show, Eq)


newtype Parser m a = P {runParser :: T.Text -> m (a, T.Text)}

instance (Functor m) => Functor (Parser m) where
  fmap f (P p) = P $ fmap (\(a, t) -> (f a, t)) . p

instance (Functor m, Monad m) => Applicative (Parser m) where
  pure a = P $ \src -> pure (a, src)
  (P f) <*> (P a) = P $ \src -> do
    (f', rest) <- f src
    (a', rest') <- a rest
    return (f' a', rest')

instance (Monad m) => Monad (Parser m) where
  (P m) >>= f = P $ \src -> do
    (a, rest) <- m src
    runParser (f a) rest

type Tokenizer = Parser Maybe Token

tokenizer :: Tokenizer
tokenizer = undefined

advance :: Parser Maybe Char
advance = P $ T.uncons

tokNumber :: Tokenizer
tokNumber = P $ \src -> undefined

test :: IO ()
test = do
  print $ runParser (advance >> advance) "hello"
