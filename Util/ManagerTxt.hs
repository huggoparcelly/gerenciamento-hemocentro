module Util.ManagerTxt where

  import Data.List.Split
  import System.IO
  import Data.List (isInfixOf)
  import Prelude as P
  import Control.Exception (evaluate)
  import Data.Time
  
  -- Funcao para add um conteudo em um arquivo txt a partir do seu nome
  -- Parametros: nome do arquivo, conteudo

  addContent :: String -> String -> IO()
  addContent fileName content = do
    let newContent = content ++ "\n"
    appendFile ("database/" ++ fileName ++ ".txt") newContent


  -- Funcao que ler todo conteudo de um txt e returna um array de string separados (splitOn) por linhas ("\n")
  -- Parametros: nome do arquivo
  readContent :: String -> IO [String]
  readContent fileName = do
      content <- openFile ("database/" ++ fileName ++ ".txt") ReadMode
      stringContent <- hGetContents content
      evaluate (P.length stringContent)
      return (P.lines stringContent)


  -- Funcao que retorna uma pessoa buscando pelo seu cpf
  -- Parametros: o nome do arquivo txt onde se quer buscar, cpf buscado
  getPersonByCpf :: String -> String -> IO String
  getPersonByCpf filename cpf = do
      contentList <- readContent filename

      getPersonByCpfRecursivo contentList cpf

  -- Funcao auxiliar na busca pelo cpf, faz uma recursao onde percorre toda a lista de conteudo do txt
  -- Parametros: Lista de conteudo, cpf buscado
  getPersonByCpfRecursivo :: [String] -> String -> IO String
  getPersonByCpfRecursivo [] cpf = return ("cpf " ++ cpf ++ " nao encontrado") -- fazer um service e colocar essa verificação lá
  getPersonByCpfRecursivo (c:cs) cpf =

      if checkCpfExist cpf c then return c
      else getPersonByCpfRecursivo cs cpf


  checkCpfExist :: String -> String -> Bool
  checkCpfExist cpf content = ("cpf = " ++ "\"" ++ cpf ++ "\"") `isInfixOf` content

  updatePersonByCpf :: String -> String -> String -> IO()
  updatePersonByCpf fileName cpf personUpdated = do

    person <- getPersonByCpf fileName cpf

    if person == "cpf " ++ cpf ++ " nao encontrado" then do putStr person

    else do
      allContent <- readContent fileName

      let path = "database/" ++ fileName ++ ".txt"
      fileHandle <- openFile path WriteMode

      updateByCpfRecursivo allContent cpf personUpdated fileHandle

      hFlush fileHandle
      hClose fileHandle


  -- Funcao que atualiza as pessoas em um arquivo txt
  updateByCpfRecursivo :: [String] -> String -> String -> Handle -> IO ()
  updateByCpfRecursivo [] cpf _ _ = return ()
  updateByCpfRecursivo (person:personList) cpf personUpdated fileHandle = do

    if checkCpfExist cpf person then do
      if personUpdated == "" then do
          updateByCpfRecursivo personList cpf personUpdated fileHandle
      else do
        hPutStrLn fileHandle personUpdated
        updateByCpfRecursivo personList cpf personUpdated fileHandle
    else do
      hPutStrLn fileHandle person
      updateByCpfRecursivo personList cpf personUpdated fileHandle


  -- Funcao para deletar uma pessoa do txt
  -- A função utilizarar do updatePerson passando como nova entrada uma string vazia
  -- Parametros nome do arquivoe cpf
  deletePersonByCpf :: String -> String -> IO()
  deletePersonByCpf fileName cpf = updatePersonByCpf fileName cpf ""


  -- Função que busca o ultimo id


  -- Funcao que retorna uma doacao pelo id

  getById :: String -> Int -> IO String
  getById fileName id = do

    contentList <- readContent fileName

    getByIdRecursivo contentList id


  getByIdRecursivo :: [String] -> Int -> IO String
  getByIdRecursivo [] id = 
    return ("id " ++ show id ++ " nao encontrado") -- fazer um service e colocar essa verificação lá
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


  getLastId :: String -> IO Int
  getLastId fileName = do
    allDoacoes <- readContent fileName

    let lastElement = last allDoacoes -- captura o ultimo elemento do array
  
    removeCharactersToId lastElement

  
  removeCharactersToId :: Monad m => String -> m Int
  removeCharactersToId element = do

    let dropElements = dropWhile (/= '=') element -- dropa os caracteres até o = ("= ID, ...")
    let takeElement = takeWhile (/= ',') dropElements -- retorna os caracteres até a , ("= ID")
    let getId = splitOn "= " takeElement -- faz um split do "= ID" (["", "ID"])
    let idStr = last getId

    return (read idStr :: Int)


  getDate :: ParseTime t => [Char] -> t
  getDate doacao = do
    
    let split = splitOn "date = " doacao
    let lastElement = last split
    let date = takeWhile (/= '}') lastElement

    let parse = parseTimeOrError True defaultTimeLocale "%Y-%-m-%-d" date
    parse
