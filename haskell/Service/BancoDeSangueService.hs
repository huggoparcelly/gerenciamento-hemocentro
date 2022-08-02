module Service.BancoDeSangueService where
  import Model.BolsaSangue ( BolsaSangue(BolsaSangue) )
  import Util.ManagerTxt
  import Util.IdManager
  import System.IO
  import Data.List
  

  checkTipoExist :: String -> String -> Bool
  checkTipoExist tipo content = ("tipoSangue = " ++ "\"" ++ tipo ++ "\"") `isInfixOf` content
  
  --Retorna todas as bolsas de sangue registradas no sistema
  getAllBags:: String -> IO [String]
  getAllBags = readContent