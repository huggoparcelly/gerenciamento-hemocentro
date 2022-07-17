module Service.RecepcaoService where

  import Util.StringManager ( getByContent, updateByContent )
  import Service.DoacaoService(getQtdFromBolsas)
  import Model.BolsaSangue (BolsaSangue(BolsaSangue))
  import Data.List ( isInfixOf )
  
  -- Realiza a coleta de uma determinada quantidade de sangue
  -- exibe uma mensagem caso o Tipo ou a quantidade não exista.
  
  realizaColeta :: IO()
  realizaColeta = do
    putStr "Tipo: "
    tipoDeSangue <- getLine    
    linhaBolsa <- getByContent "BolsaSangue" tipoDeSangue
    if checkTipoExist tipoDeSangue linhaBolsa then do
        putStr "Quantidade: "
        quantidade <- getLine
        let qtdSolicitadaInt = read quantidade :: Int
        qtdEstoque <- Service.DoacaoService.getQtdFromBolsas linhaBolsa
        if qtdEstoque >= qtdSolicitadaInt then do
            let qtdAtt = qtdEstoque - qtdSolicitadaInt
            let bolsaNew = BolsaSangue tipoDeSangue qtdAtt
            updateByContent "BolsaSangue" tipoDeSangue $show bolsaNew
            putStrLn "Bolsas entregues!"
        else do
            putStrLn "Não temos a quantidade solicitada."

    else do
        putStrLn "Tipo de sangue invalido."


  checkTipoExist :: String -> String -> Bool
  checkTipoExist tipo content = ("tipoSangue = " ++ "\"" ++ tipo ++ "\"") `isInfixOf` content
    
  
