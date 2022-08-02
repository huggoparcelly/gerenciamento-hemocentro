module Service.RecepcaoService where

  import Util.StringManager ( getByContent, updateByContent, checkIfExist )
  import Service.DoacaoService(getQtdFromBolsas)
  import Model.BolsaSangue
  import Data.List ( isInfixOf )
  
  -- Realiza a coleta de uma determinada quantidade de sangue
  -- exibe uma mensagem caso o Tipo ou a quantidade não exista.
  
  realizaColeta :: IO()
  realizaColeta = do
    putStr "Tipo: "
    tipoDeSangue <- getLine
    linhaBolsa <- getByContent "BolsaSangue" tipoDeSangue

    if checkIfExist tipoDeSangue linhaBolsa then do
        putStr "Quantidade: "
        qtdSolicitada <- readLn
        
        qtdEstoque <- getQtdFromBolsas linhaBolsa
        
        if qtdEstoque >= qtdSolicitada then do
            let qtdAtt = qtdEstoque - qtdSolicitada
            let bolsaNew = BolsaSangue tipoDeSangue qtdAtt

            updateByContent "BolsaSangue" tipoDeSangue $show bolsaNew
            putStrLn "Bolsas entregues!"
        else do
            putStrLn "Não temos a quantidade solicitada."

    else do
        putStrLn "Tipo de sangue invalido."
    
  
