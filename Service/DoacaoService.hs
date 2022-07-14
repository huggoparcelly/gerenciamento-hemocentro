module Service.DoacaoService where

  import Util.ManagerTxt
  import Util.IdManager
  import Model.Doacao

  import Data.Time.Clock
  import Data.Time.Calendar
  import qualified Data.Functor
  import Data.List.Split
  import Util.StringManager (getByContent, deleteByContent)
  
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
    person <- getByContent fileDoadores cpf 
    -- chama a funcao que incrementa o id
    id <- incrementaId fileName
    
    putStr "Tipo de sangue: "
    tipo <- getLine
    putStr "Quantidade: "
    qnt <- readLn
    dateNow <- today

    let pessoa = Doacao id person tipo qnt dateNow

    addContent fileName $ show pessoa

  createDoacaoDirecionada :: String -> IO()
  createDoacaoDirecionada fileName = do
    putStr "Cpf do receptor: "
    cpf <- getLine
    person <- getByContent fileReceptores cpf 

    if checkIfExist cpf then do                    --verifica se o receptor existe
      putStr "Cpf do doador: "
      cpfDoador <- getLine
      person <- getByContent fileDoadores cpfDoador
      
      if checkIfExist cpfDoador then do                    --verifica se o doador existe
        id <- incrementaId fileName
    
        putStr "Tipo de sangue: "
        tipo <- getLine
        putStr "Quantidade: "
        qnt <- readLn
        dateNow <- today

        let pessoa = Doacao id person tipo qnt dateNow

        addContent fileName $ show pessoa
      else do                                             --se receptor nao existir, a doaçao acontece de forma normal
        cpf <- createDoacao
    else do                                               --se o doador nao existir, ele é redirecionado para o cadastro
      cpf <- createPerson
      

    -- TODO
    -- verificacao se o doador nao existir ser redirecionado para o cadastro (menu)
    -- verificacao para o menu ou service e na criacao passa a person como parâmetro.
    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getContentByCpf fileDoadores cpf 
    -- chama a funcao que incrementa o id
    id <- incrementaId fileName
    dateNow <- today
    let pessoa = Doacao id person dateNow
    addContent fileName $ show pessoa


  getAllDoacoes :: String -> IO [String]
  getAllDoacoes fileDoacoes = readContent fileDoacoes

  getDoacaoById :: String -> IO String
  getDoacaoById fileName = do

    -- Chama a funcao de input que busca um id
    idToFind <- searchId

    getByContent fileName idToFind


  putById :: String -> IO ()
  putById fileName = do

    doacao <- getDoacaoById fileName

    -- capturar o id
    id <- removeCharactersToId doacao

    putStr "Cpf do doador: "
    cpf <- getLine
    person <- getByContent fileDoadores cpf -- verificacao se o doador nao existir ser redirecionado para o cadastro (menu)

    putStr "Tipo de sangue: "
    tipo <- getLine
    -- putStr "Quantidade: "
    -- qnt <- readLn

    let date = getDate doacao -- captura a data

    -- let doacaoUpdated = Doacao id person tipo qnt date
    let doacaoUpdated = Doacao id person

    updateById fileName id $ show doacaoUpdated

  removeDoacaoById :: String -> IO ()
  removeDoacaoById fileName = do
    id <- searchId
    deleteByContent fileName id