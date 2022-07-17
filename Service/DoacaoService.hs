module Service.DoacaoService where

  import Util.ManagerTxt
  import Util.IdManager
  import Model.Doacao
  import Data.Time.Clock
  import Data.Time.Calendar
  import Util.StringManager
  import Model.BolsaSangue
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

  fileNameDoacoes :: String 
  fileNameDoacoes = "Doacoes"


{-  Cria uma doação no Docacoes.txt, consequentemente um Comprovante de Doação também é criado
    e incrementa o estoque de sangue com o que foi doado.
    Captura as inforamções via console
-}
  createDoacao :: IO()
  createDoacao = do
    putStr "CPF do doador: "
    cpf <- getLine

    person <- getByContent fileNameDoadores cpf

    id <- incrementaId fileNameDoacoes

    putStr "Tipo de sangue: "
    tipo <- getLine

    putStr "Quantidade: "
    qnt <- readLn

    dateNow <- today

    let doacao = Doacao id person tipo qnt dateNow

    createComprovante cpf dateNow

    linhaBolsa <- getByContent fileNameBolsas tipo
    qtdOld <- getQtdFromBolsas linhaBolsa

    let qtdAtt = qnt + qtdOld

    let bolsaNew = BolsaSangue tipo qtdAtt

    updateByContent fileNameBolsas tipo $show bolsaNew

    addContent fileNameDoacoes $show doacao


{-  Busca em uma linha do tipo BolsaSangue a quantidade atual
    Parametros = element: linha do tipo BolsaSangue
    Retorno    = quantidade de sangue atual
-}
  getQtdFromBolsas :: Monad m => String -> m Int
  getQtdFromBolsas element = do
    let teste = dropWhile (/= ',') element
    let dropElements = dropWhile (/= '=') teste -- dropa os caracteres até o = ("= ID, ...")
    let takeElement = takeWhile (/= '}') dropElements -- retorna os caracteres até a , ("= ID")
    let getId = words takeElement  -- faz um split do "= ID" (["", "ID"])
    let idStr = last getId
    return (read idStr :: Int)


{-  Cria uma doação direcionada a uma pessoa cadastrada em Receptores.text
    Captura as informações via console 
-}
  createDoacaoDirecionada :: IO()
  createDoacaoDirecionada = do
    putStr "CPF do receptor: "
    cpf <- getLine
    receptor <- getByContent fileNameReceptores cpf

    if checkIfExist cpf receptor then do
      putStr "CPF do doador: "
      cpfDoador <- getLine
      doador <- getByContent fileNameDoadores cpfDoador
      if checkIfExist cpfDoador doador then do
        id <- incrementaId fileNameDoacoes

        putStr "Tipo de sangue: "
        tipo <- getLine
        putStr "Quantidade: "
        qnt <- readLn
        dateNow <- today

        createComprovante cpf dateNow

        let doacao = Doacao id doador tipo qnt dateNow
        addContent fileNameDoacoes $ show doacao
      else do
        putStrLn "Vamos se cadastrar para poder ajudar mais pessoas?"
        createPerson "Doadores"
    else do
      putStrLn "Seu receptor é inexistente, mas sua doação será armazenada em nosso banco."
      createDoacao


{-  Busca todas as Doações cadastradas em Doacoes.text
    Retorno    = todas as doações
-}
  getAllDoacoes :: IO [String]
  getAllDoacoes = readContent fileNameDoacoes


{-  Busca uma doação pelo ID
    ID capturado via console
    Retorno    = doação do tipo Doacao
-} 
  getDoacaoById :: IO String
  getDoacaoById = do
    idToFind <- searchId
    getByContent fileNameDoacoes idToFind
