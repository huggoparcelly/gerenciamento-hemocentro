module Service.DoacaoService where

  import Util.ManagerTxt
  import Model.Doacao

  import Data.Time.Clock
  import Data.Time.Calendar
  import qualified Data.Functor
  import Data.List.Split

  today :: IO Day   -- :: (yyyy-mm-dd)
  today = utctDay <$> getCurrentTime

  fileDoadores :: String
  fileDoadores = "Doadores"

  createDoacao :: String -> IO()
  createDoacao fileName = do

    putStr "Cpf do doador: "
    cpf <- getLine

    person <- getPersonByCpf fileDoadores cpf -- verificacao se o doador nao existir ser redirecionado para o cadastro (menu)

    -- busca o ultimo id e incrementa 1
    lastId <- getLastId fileName
    let id = lastId + 1
    
    putStr "Tipo de sangue: "
    tipo <- getLine
    putStr "Quantidade: "
    qnt <- readLn
    dateNow <- today

    let pessoa = Doacao id person tipo qnt dateNow

    addContent fileName $ show pessoa


  getAllDoacoes :: String -> IO [String]
  getAllDoacoes = readContent

  searchId :: IO Int
  searchId = do
    putStr "Id buscado: "
    readLn


  getDoacaoById :: String -> IO String
  getDoacaoById fileName = do

    idToFind <- searchId

    getById fileName idToFind


  putById :: String -> IO ()
  putById fileName = do

    doacao <- getDoacaoById fileName

    -- capturar o id
    id <- removeCharactersToId doacao

    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getPersonByCpf fileDoadores cpf -- verificacao se o doador nao existir ser redirecionado para o cadastro (menu)

    putStr "Tipo de sangue: "
    tipo <- getLine
    putStr "Quantidade: "
    qnt <- readLn

    let date = getDate doacao -- captura a data

    let doacaoUpdated = Doacao id person tipo qnt date

    updateById fileName id $ show doacaoUpdated


  removeById :: String -> IO ()
  removeById fileName = do
    id <- searchId
    deleteById fileName id