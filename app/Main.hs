module Main where

  import Utils.CrudTxt

main :: IO ()
main = do
  putStr ("Nome: ")
  nome <- getLine
  putStr ("CPF: ")
  cpf <- getLine

  let doador = Pessoa parametros

  addContent "Receptores" $ show doador