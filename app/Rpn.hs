module Main where
import System.Console.Isocline (readline)

eval :: String -> Float  
eval = head . foldl fn [] . words 
  where fn (x:y:ys) "*" = (x * y):ys
        fn (x:y:ys) "+" = (x + y):ys
        fn (x:y:ys) "-" = (y - x):ys
        fn (x:y:ys) "/" = (y / x):ys
        fn (x:y:ys) "^" = (y ** x):ys
        fn xs     "sum" = [sum xs]
        fn xs     "log" = [log $ head xs]
        fn xs ns = read ns:xs

main = do
  input <- readline "calc"
  print $ eval input
  main