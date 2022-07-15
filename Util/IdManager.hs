module Util.IdManager where

  import Data.List
  import System.IO
  import Prelude as P
  import Util.ManagerTxt

  -- Input de entrada para buscar um id
  searchId :: IO String
  searchId = do
    putStr "Id buscado: "
    getLine

  -- busca o ultimo id e incrementa 1
  incrementaId :: String -> IO String
  incrementaId fileName = do
    lastId <- getLastId fileName
    let lastId2 = lastId + 1
    let retorno = show lastId2 :: String
    return retorno


  -- Função que busca o ultimo id
  getLastId :: String -> IO Int
  getLastId fileName = do
    allDoacoes <- readContent fileName
    if null allDoacoes then removeCharactersToId ""
    else do
      let lastElement = last allDoacoes -- captura o ultimo elemento do array
      removeCharactersToId lastElement


  removeCharactersToId :: Monad m => String -> m Int
  removeCharactersToId element = do
    if element == "" then return 0
    else do
      let drops = dropWhile (/= '=') element
      let drops2 = takeWhile (/= ',') drops
      let getW = words drops2
      let lastW = last getW
      let drops3 = dropWhile (== '\"') lastW
      let drops4 = takeWhile (/= '\"') drops3
      return (read drops4 :: Int)


