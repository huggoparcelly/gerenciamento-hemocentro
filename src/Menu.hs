module Menu where
  import Util.CrudTxt
  import Model.Pessoa

  menu :: IO ()
  menu = do
    putStr ("Nome: ")
    nome <- getLine
    putStr ("CPF: ")
    cpf <- getLine

    let doador = Pessoa cpf nome

    addContent "Receptores" $ show doador