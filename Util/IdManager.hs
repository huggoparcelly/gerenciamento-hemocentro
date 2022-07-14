module Util.IdManager where

  import Data.List
  import System.IO
  import Prelude as P
  import Util.ManagerTxt

  -- Input de entrada para buscar um id
  searchId :: IO Int
  searchId = do
    putStr "Id buscado: "
    readLn

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

    let lastElement = last allDoacoes -- captura o ultimo elemento do array

    removeCharactersToId lastElement


  removeCharactersToId :: Monad m => String -> m Int
  removeCharactersToId element = do
    let dropElements = dropWhile (/= '=') element -- dropa os caracteres até o = ("= ID, ...")
    let takeElement = takeWhile (/= ',') dropElements -- retorna os caracteres até a , ("= ID")
    let getId = words "= "  -- faz um split do "= ID" (["", "ID"])
    let idStr = last getId

    return (read idStr :: Int)