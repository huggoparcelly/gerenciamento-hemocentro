module Util.IdManager where

  import Data.List
  import System.IO
  import Prelude as P
  import Util.ManagerTxt

  -- Solicita ao usuario que digite um id para ser buscado
  -- Retorna o id que foi digitado pelo usuario como string 
  searchId :: IO String
  searchId = do
    putStr "Id buscado: "
    getLine

  -- Busca o ultimo id e incrementa 1
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id,
  -- Retorna o ultimo id incrementado de 1
  incrementaId :: String -> IO String
  incrementaId fileName = do
    lastId <- getLastId fileName
    let lastId2 = lastId + 1
    let retorno = show lastId2 :: String
    return retorno


  -- Função que busca o ultimo id
  -- busca todo conteudo do txt
  -- utiliza-se da funcao removeCharactersToId para fazer a manipulacao da string
  -- passando um conteudo vazio caso nao existe nada armazenado no txt
  -- ou passando o ultimo elemento do array que foi encontrado
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id,
  -- Retorna o ultimo id
  getLastId :: String -> IO Int
  getLastId fileName = do
    allContent <- readContent fileName
    if null allContent then removeCharactersToId ""
    else do
      let lastElement = last allContent
      removeCharactersToId lastElement

  -- Manipula a string que foi recebida para retornar o valo do id
  -- caso o conteudo passado seja um conteudo vazido retorna o id como 0
  -- caso receba uma string com conteudo, então é feito as devidas manipulacoes para retornar apenas o numero do id
  -- Parametros= element: uma string a ser manipulada
  -- Retorna o valor do id em inteiro
  removeCharactersToId :: Monad m => String -> m Int
  removeCharactersToId content = do
    if content == "" then return 0
    else do
      let drops = dropWhile (/= '=') content
      let take = takeWhile (/= ',') drops
      let getW = words take
      let lastW = last getW
      let drops2 = dropWhile (== '\"') lastW
      let take2 = takeWhile (/= '\"') drops2
      return (read take2 :: Int)


