module Menu where
  import Util.CrudTxt

  menu :: IO ()
    putStr ("Nome: ")
    nome <- getLine
    putStr ("CPF: ")
    cpf <- getLine

    let doador = Pessoa parametros

    addContent "Receptores" $ show doador