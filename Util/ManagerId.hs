module Util.ManagerId where

  import Util.ManagerTxt ( getLastId )

  -- Input de entrada para buscar um id
  searchId :: IO Int
  searchId = do
    putStr "Id buscado: "
    readLn

  -- busca o ultimo id e incrementa 1
  incrementaId :: String -> IO Int
  incrementaId fileName = do
    lastId <- getLastId fileName
    return (lastId + 1)


  -- buscar o cpf(id) do doador
  searchCpf:: IO String
  searchCpf = do 
    putStr "Cpf doador: "
    getLine