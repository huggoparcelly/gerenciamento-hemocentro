{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Util.StringManager where

  import Data.List
  import System.IO
  import Prelude as P
  import Data.Time
  import Util.ManagerTxt


  -- buscar o cpf(id) do doador
  searchCpf:: IO String
  searchCpf = do
    putStr "Cpf doador: "
    getLine


  getByContent :: String -> String -> IO String
  getByContent filename content = do
    contentList <- readContent filename
    getByContentRecursivo contentList content


  getByContentRecursivo :: [String] -> String -> IO String
  getByContentRecursivo [] content =
    return "Não encontrado."
  getByContentRecursivo (d:ds) content =
    if checkIfExist content d then return d
    else getByContentRecursivo ds content


  checkIfExist :: String -> String -> Bool
  checkIfExist str content
    | "id" `isInfixOf` content =
      ("id = " ++ "\"" ++ str ++ "\"") `isInfixOf` content
    | "cpf" `isInfixOf` content =
      ("cpf = " ++ "\"" ++ str ++ "\"") `isInfixOf` content
    | "tipoSangue" `isInfixOf` content =
      ("tipoSangue = " ++ "\"" ++ str ++ "\"") `isInfixOf` content


  updateByContent :: String -> String -> String -> IO()
  updateByContent fileName content modelUpdate = do
    model <- getByContent fileName content
    if model == "Não encontrado." then do putStr model
    else do
      allContent <- readContent fileName

      let path = "database/" ++ fileName ++ ".txt"
      fileHandle <- openFile path WriteMode

      updateByContentRecursivo allContent content modelUpdate fileHandle

      hFlush fileHandle
      hClose fileHandle


  updateByContentRecursivo :: [String] -> String -> String -> Handle -> IO ()
  updateByContentRecursivo [] content _ _ = return ()
  updateByContentRecursivo (model:modelList) content modelUpdate fileHandle = do
    if checkIfExist content model then do
      if modelUpdate == "" then do
        updateByContentRecursivo modelList content modelUpdate fileHandle
      else do
        hPutStrLn fileHandle modelUpdate
        updateByContentRecursivo modelList content modelUpdate fileHandle
    else do
      hPutStrLn fileHandle model
      updateByContentRecursivo modelList content modelUpdate fileHandle


  -- Funcao para deletar uma pessoa do txt
  -- A função utilizarar do updatePerson passando como nova entrada uma string vazia
  -- Parametros nome do arquivoe cpf
  deleteByContent :: String -> String -> IO()
  deleteByContent fileName content = updateByContent fileName content ""