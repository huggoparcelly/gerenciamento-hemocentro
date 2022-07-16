module Service.PersonService where

  import Model.Person
  import Util.ManagerTxt
  import Util.IdManager
  import Util.StringManager
  
  -- Cria uma pessoa que podera ser um doador ou um receptor
  -- pede ao usuario que digite os dados da pessoa a ser criada
  -- cria uma entidade pessoa e adiciona esse conteudo em um txt
  -- imprime na tela que o usuario foi cadastrado com sucesso
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id
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


  -- Realiza a busca de todas as pessoas nos bancos de dados de doador ou receptores
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id
  -- Retorna um array com todas as pessoas do banco escolhido
  getAllPeople :: String -> IO [String]
  getAllPeople = readContent

  -- Busca uma pessoa pelo cpf
  -- é solicitado que o usuario digite o cpf a ser buscado
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id
  -- Retorna uma string com a pessoa busca ou com o valor "não encontrado"
  getByCpf :: String -> IO String
  getByCpf fileName = do
    cpfToFind <- searchCpf
    getByContent fileName cpfToFind

  -- Atualiza uma pessoa
  -- busca a pessoa que deseja atualizar pelo cpf
  -- pede ao usuario que digite os dados atualizados da pessoa
  -- cria uma entidade pessoa com novos dados 
  -- atualiza uma pessoa com a funcao updateByContent
  -- imprime na tela que o usuario foi cadastrado com sucesso
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id
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

    updateByContent fileName cpfToFind $ show newPessoa
    
    putStrLn "Usuário atualizado com sucesso."

  -- Funcao que deleta uma pessoa do seu respectivo banco de dados
  -- solicita que o usuario digite o cpf a ser deletado
  -- realiza a delecao com a funcao deleteByContent
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id
  deletePerson :: String -> IO ()
  deletePerson fileName = do
    cpfToFind <- searchCpf
    deleteByContent fileName cpfToFind