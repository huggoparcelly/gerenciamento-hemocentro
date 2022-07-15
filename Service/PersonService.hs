module Service.PersonService where

  import Model.Person
  import Util.ManagerTxt
  import Util.IdManager
  import Util.StringManager
  
  
  -- TODO adicionar os outros atributos solicitados para cadastro do doador
  createPerson :: String -> IO()
  createPerson fileName = do
    putStr "Nome: "
    name <- getLine
    putStr "Cpf: "
    cpf <- getLine

    let pessoa = Person cpf name

    addContent fileName $ show pessoa
    putStrLn "Usuário cadastrado com sucesso!"


  getAllPeople :: String -> IO [String]
  getAllPeople = readContent

  getByCpf :: String -> IO String
  getByCpf fileName = do
    cpfToFind <- searchCpf
    getByContent fileName cpfToFind


  putByCpf :: String -> IO ()
  putByCpf fileName = do
    cpfToFind <- searchCpf

    -- TODO adicionar os outros atributos de uma pessoa (sempre atualiza tudo)
    putStr "Nome: "
    name <- getLine
    putStr "Cpf: "
    cpf <- getLine
    let newPessoa = Person cpf name

    updateByContent fileName cpf $ show newPessoa
    putStrLn "Usuário atualizado com sucesso."


  deletePerson :: String -> IO ()
  deletePerson fileName = do
    cpfToFind <- searchCpf
    deleteByContent fileName cpfToFind