module Lib
    ( catStdIn
    , sortLines
    ) where
import System.IO ( isEOF )
import Control.Monad (unless)
import Data.Char (toLower)
import Data.List (sort)

-- | Cat the standard input to the standard output.
catStdIn :: IO ()
catStdIn = do 
  done <- isEOF
  unless done $ do 
    inp <- getLine
    putStrLn inp
    catStdIn

sortLines :: String -> String
sortLines = sort . map toLower