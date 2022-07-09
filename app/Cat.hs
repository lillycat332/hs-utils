module Main where
import System.Directory
import System.IO
import System.Exit
import System.Environment
import Control.Monad (when, unless)

main :: IO ()
main = do
  argv <- getArgs

  when (not $ null argv) $ do 
    mapM_ (\x -> do 
      f <- openFile x ReadMode
      h <- hGetContents f
      putStrLn h
      hClose f) argv
  
  when (null argv) $ do
    catStdIn

catStdIn :: IO ()
catStdIn = do 
  done <- isEOF
  unless done $ do 
    inp <- getLine
    putStrLn inp
    catStdIn
