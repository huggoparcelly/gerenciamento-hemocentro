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

  -- Funcao que retorna uma doacao pelo id
  getById :: String -> Int -> IO String
  getById fileName id = do
    contentList <- readContent fileName
    getByIdRecursivo contentList id


  getByIdRecursivo :: [String] -> Int -> IO String
  getByIdRecursivo [] id =
    return ("id " ++ show id ++ " nao encontrado")
  getByIdRecursivo (d:ds) id =
      if checkIdExist id d then return d
      else getByIdRecursivo ds id


  checkIdExist :: Int -> String -> Bool
  checkIdExist id content = ("id = " ++ show id ++ ",") `isInfixOf` content


  updateById :: String -> Int -> String -> IO ()
  updateById fileName id contentUpdate = do
    content <- getById fileName id
    if content == ("id = " ++ show id ++ ",") then do putStr content
    else do
      allContent <- readContent fileName

      let path = "database/" ++ fileName ++ ".txt"
      fileHandle <- openFile path WriteMode

      updateByIdRecursivo allContent id contentUpdate fileHandle

      hFlush fileHandle
      hClose fileHandle


  updateByIdRecursivo :: [String] -> Int -> String -> Handle -> IO ()
  updateByIdRecursivo [] _ _ _ = do return ()
  updateByIdRecursivo (content:contentList) id contentUpdate fileHandle = do
    if checkIdExist id content then do
      if contentUpdate == "" then do
        updateByIdRecursivo contentList id contentUpdate fileHandle
      else do
        hPutStrLn fileHandle contentUpdate
        updateByIdRecursivo contentList id contentUpdate fileHandle
    else do
      hPutStrLn fileHandle content
      updateByIdRecursivo contentList id contentUpdate fileHandle


  deleteById :: String -> Int -> IO()
  deleteById fileName id = updateById fileName id ""


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