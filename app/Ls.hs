module Main where

import Lib
import System.Directory
import System.Exit
import Options.Applicative
import qualified Control.Exception as Ex
import qualified System.IO.Error as IOE
import qualified GHC.IO.Exception as GIOE

data Args = Args
  { argsDir    :: String
  , argsAll    :: Bool
  }

p :: Parser String
p = argument str (metavar "directory" <> value ".")

args :: Parser Args
args = Args <$> 
  p <*> 
  switch 
  (  long "all"
  <> short 'a' 
  <> help "Show all files"
  )

main :: IO ()
main = do
  args <- execParser opts

  if argsAll args then mainWithArgs (getDirectoryContents) (argsDir args)
  else Ex.catch (mainWithArgs (listDirectory) (argsDir args)) (handler)

  where
    opts = info (args <**> helper)
      (  fullDesc
      <> progDesc "Prints the contents of a directory"
      <> header "ls - Prints the contents of a directory"
      )
    handler :: IOError -> IO ()  
    handler e
      | IOE.isDoesNotExistError e = putStrLn "ls: No such file or directory"  
      | IOE.isPermissionError   e = putStrLn "ls: Permission denied"
      | IOE.isIllegalOperation  e = putStrLn "ls: Illegal operation"
      | IOE.isFullError         e = putStrLn "ls: Insufficient resources to perform the operation"
      | otherwise                 = ioError e 

mainWithArgs fn dir = do
  contents <- fn dir
  mapM_ putStrLn contents
