module Service.DoacaoService where

  import Util.ManagerTxt
  import Util.IdManager
  import Model.Doacao
  import Data.Time.Clock
  import Data.Time.Calendar
  import qualified Data.Functor
  import Util.StringManager
  import Model.BolsaSangue (BolsaSangue(BolsaSangue))
  import Service.PersonService
  import Service.ComprovanteService

  today :: IO Day   -- :: (yyyy-mm-dd)
  today = utctDay <$> getCurrentTime

  fileNameDoadores :: String
  fileNameDoadores = "Doadores"

  fileNameBolsas :: String
  fileNameBolsas = "BolsaSangue"

  fileNameReceptores :: String
  fileNameReceptores = "Receptores"


  createDoacao :: String -> IO()
  createDoacao fileName = do
    putStr "CPF do doador: "
    cpf <- getLine

    person <- getByContent fileNameDoadores cpf

    id <- incrementaId fileName

    putStr "Tipo de sangue: "
    tipo <- getLine

    putStr "Quantidade: "
    qnt <- readLn

    dateNow <- today

    let doacao = Doacao id person tipo qnt dateNow

    createComprovante "ComprovanteDoacao" cpf dateNow

    linhaBolsa <- getByContent fileNameBolsas tipo
    qtdOld <- getQtdFromBolsas linhaBolsa

    let qtdAtt = qnt + qtdOld

    let bolsaNew = BolsaSangue tipo qtdAtt

    updateByContent fileNameBolsas tipo $show bolsaNew

    addContent fileName $show doacao


  getQtdFromBolsas :: Monad m => String -> m Int
  getQtdFromBolsas element = do
    let teste = dropWhile (/= ',') element
    let dropElements = dropWhile (/= '=') teste -- dropa os caracteres até o = ("= ID, ...")
    let takeElement = takeWhile (/= '}') dropElements -- retorna os caracteres até a , ("= ID")
    let getId = words takeElement  -- faz um split do "= ID" (["", "ID"])
    let idStr = last getId

    return (read idStr :: Int)


  createDoacaoDirecionada :: String -> IO()
  createDoacaoDirecionada fileName = do
    putStr "CPF do receptor: "
    cpf <- getLine
    receptor <- getByContent fileNameReceptores cpf

    if checkIfExist cpf receptor then do                    --verifica se o receptor existe
      putStr "CPF do doador: "
      cpfDoador <- getLine
      doador <- getByContent fileNameDoadores cpfDoador

      if checkIfExist cpfDoador doador then do                    --verifica se o doador existe
        id <- incrementaId fileName

        putStr "Tipo de sangue: "
        tipo <- getLine
        putStr "Quantidade: "
        qnt <- readLn
        dateNow <- today

        let doacao = Doacao id doador tipo qnt dateNow

        createComprovante "ComprovanteDoacao" cpf dateNow

        addContent fileName $ show doacao
      else do                                             --se receptor nao existir, a doaçao acontece de forma normal
        putStrLn "Vamos se cadastrar para poder ajudar mais pessoas?"
        createPerson "Doadores"
    else do                                               --se o doador nao existir, ele é redirecionado para o cadastro
      putStrLn "Seu receptor é inexistente, mas sua doação será armazenada em nosso banco."
      createDoacao "Doacoes"


  getAllDoacoes :: String -> IO [String]
  getAllDoacoes = readContent

  getDoacaoById :: String -> IO String
  getDoacaoById fileName = do
    idToFind <- searchId
    getByContent fileName idToFind
