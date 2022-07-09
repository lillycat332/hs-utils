module Main where
import System.Directory
import System.IO
import System.Exit
import System.Environment
import Control.Monad ( when, unless )
import Lib ( catStdIn )


-- Not using optparse-applicative because it doesn't seem to have a way to
-- have lists of arguments...
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
