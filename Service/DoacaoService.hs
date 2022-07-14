module Service.DoacaoService where

  import Util.ManagerTxt
  import Util.IdManager
  import Model.Doacao
  import Data.Time.Clock
  import Data.Time.Calendar
  import qualified Data.Functor
  import Util.StringManager
  -- import Data.List.Split

  today :: IO Day   -- :: (yyyy-mm-dd)
  today = utctDay <$> getCurrentTime

  fileDoadores :: String
  fileDoadores = "Doadores"

  createDoacao :: String -> IO()
  createDoacao fileName = do
    -- TODO
    -- verificacao se o doador nao existir ser redirecionado para o cadastro (menu)
    -- verificacao para o menu ou service e na criacao passa a person como parâmetro.
    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getByContent fileDoadores $show cpf
    -- chama a funcao que incrementa o id
    id <- incrementaId fileName
    -- putStr "Tipo de sangue: "
    -- tipo <- getLine
    -- putStr "Quantidade: "
    -- qnt <- readLn
    -- dateNow <- today

    -- let pessoa = Doacao id person tipo qnt dateNow
    let pessoa = Doacao id person
    
    addContent fileName $ show pessoa


  getAllDoacoes :: String -> IO [String]
  getAllDoacoes = readContent


  getDoacaoById :: String -> IO String
  getDoacaoById fileName = do
    -- Chama a funcao de input que busca um id
    idToFind <- searchId
    getById fileName idToFind


  putById :: String -> IO ()
  putById fileName = do

    doacao <- getDoacaoById fileName
    -- capturar o id
    -- let id = show (removeCharactersToId doacao) :: String

    idInt <- removeCharactersToId doacao
    let id = show idInt :: String

    -- id <- teste

    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getByContent fileDoadores cpf -- verificacao se o doador nao existir ser redirecionado para o cadastro (menu)

    putStr "Tipo de sangue: "
    tipo <- getLine
    -- putStr "Quantidade: "
    -- qnt <- readLn

    -- let date = getDate doacao -- captura a data
    -- let doacaoUpdated = Doacao id person tipo qnt date
    let doacaoUpdated = Doacao id person

    updateByContent fileName id $ show doacaoUpdated


  removeById :: String -> IO ()
  removeById fileName = do
    id <- searchId
    deleteById fileName id