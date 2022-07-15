 module Service.DoacaoMedulaService where
  import Util.ManagerTxt
  import Util.IdManager
  import Model.Doacao

  import Data.Time.Clock
  import Data.Time.Calendar
  import qualified Data.Functor
  import Data.List.Split
  import Util.StringManager (getByContent, deleteByContent)
  
  createDoacaoMedula :: String -> IO()
  createDoacaoMedula fileName = do
    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getByContent fileDoadores cpf 
    id <- incrementaId fileName  -- chama a funcao que incrementa o id
    

    dateNow <- today

    let doacao = Doacao id person dateNow
    addContent fileDoacoesMedula $ show doacao

  getAllDoacoesMedula :: String -> IO [String]
  getAllDoacoesMedula  = readContent 

  getAllComprovanteDoacoesMedula :: String -> IO [String]
  getAllComprovanteDoacoesMedula  = readContent 
