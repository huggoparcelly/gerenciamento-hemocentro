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


  --Retorna uma bolsa em específico do banco de dados
  -- getBag:: String -> IO String
  -- getBag fileName = do
  --   -- Chama a funcao de input que busca um id
  --   idToFind <- searchId
  --   getById fileName idToFind


  -- TODO fazer o put do banco de sangue para quando houver doação ou transferencia de sangue mudar a quantidade