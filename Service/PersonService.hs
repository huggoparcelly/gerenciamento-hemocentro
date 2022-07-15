module Service.PersonService where

  import Model.Person
  import Util.ManagerTxt
  import Util.IdManager
  import Util.StringManager
  
  
  createPerson :: String -> IO()
  createPerson fileName = do
    putStr "Nome: "
    name <- getLine
    putStr "Cpf: "
    cpf <- getLine
    putStr "Telefone: "
    tel <- getLine
    putStr "Endereco: "
    end <- getLine
    putStr "Tipo sanguineo: "
    tipoSangue <- getLine

    let pessoa = Person cpf name tel end tipoSangue

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

    putStr "Nome: "
    name <- getLine
    putStr "Cpf: "
    cpf <- getLine
    putStr "Telefone: "
    tel <- getLine
    putStr "Endereco: "
    end <- getLine
    putStr "Tipo sanguineo: "
    tipoSangue <- getLine

    let newPessoa = Person cpf name tel end tipoSangue

    updateByContent fileName cpf $ show newPessoa
    putStrLn "Usuário atualizado com sucesso."

  deletePerson :: String -> IO ()
  deletePerson fileName = do
    cpfToFind <- searchCpf
    deleteByContent fileName cpfToFind