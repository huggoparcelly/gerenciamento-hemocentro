-- module Service.PersonService where

--   import Model.Person
--   import Util.ManagerTxt
  

--   -- TODO adicionar os outros atributos solicitados para cadastro do doador
--   createPerson :: String -> IO()
--   createPerson fileName = do
--     putStr "Nome: "
--     name <- getLine
--     putStr "Cpf: "
--     cpf <- getLine

--     let pessoa = Person cpf name

--     addContent fileName $ show pessoa


--   getAllPersons :: String -> IO [String]
--   getAllPersons = readContent

--   getByCpf :: String -> IO String
--   getByCpf fileName = do
--     cpfToFind <- searchCpf

--     getContentByCpf fileName cpfToFind


--   putByCpf :: String -> IO ()
--   putByCpf fileName = do
--     cpfToFind <- searchCpf

--     -- TODO adicionar os outros atributos de uma pessoa (sempre atualiza tudo)
--     putStr "Nome: "
--     name <- getLine
--     putStr "Cpf: "
--     cpf <- getLine
--     let newPessoa = Person cpf name

--     updatePersonByCpf fileName cpf $ show newPessoa


--   deletePerson :: String -> IO ()
--   deletePerson fileName = do
--     cpfToFind <- searchCpf
--     deletePersonByCpf fileName cpfToFind