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
    putStr "Nome: "
    dateNow <- today

    let pessoa = Doacao id person dateNow
    addContent fileDoacoesMedula $ show pessoa

  getAllDoacoesMedula :: String -> IO [String]
  getAllDoacoesMedula fileDoacoesMedula = readContent fileDoacoesMedula

  getAllComprovanteDoacoesMedula :: String -> IO [String]
  getAllComprovanteDoacoesMedula fileDoacoesMedula = readContent fileDoacoesMedula
