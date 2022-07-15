 module Service.DoacaoMedulaService where
  import Util.ManagerTxt
  import Util.IdManager
  import Data.Time.Clock
  import Data.Time.Calendar
  import Util.StringManager (getByContent, deleteByContent)
  import Model.Medula
  import Service.ComprovanteService
  
  today :: IO Day   -- :: (yyyy-mm-dd)
  today = utctDay <$> getCurrentTime

  createDoacaoMedula :: String -> IO()
  createDoacaoMedula fileName = do
    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getByContent "Doadores" cpf

    id <- incrementaId fileName  -- chama a funcao que incrementa o id
    
    dateNow <- today

    let pessoa = Medula id person dateNow

    createComprovante "ComprovanteDoacao" cpf dateNow
    
    addContent fileName $ show pessoa

  getAllDoacoesMedula :: String -> IO [String]
  getAllDoacoesMedula = readContent

  getAllComprovanteDoacoesMedula :: String -> IO [String]
  getAllComprovanteDoacoesMedula = readContent
