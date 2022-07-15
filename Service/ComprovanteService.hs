module Service.ComprovanteService where

  import Model.ComprovanteDoacao
  import Util.ManagerTxt
  import Util.IdManager
  --  import Service.DoacaoService (getDoacaoById)
  import Util.StringManager  
  import Data.Time
  
 --Registra um novo comprovante no sistema 
  createComprovante:: String -> String -> Day -> IO()
  createComprovante fileName cpf dia = do
   
   let texto = "Declaramos para os devidos fins e com agradecimentos que o(a) Sr(a), inscrito(a) no CPF sob o nº: " ++ cpf ++
        " , doou sangue voluntariamente ao(à) Hemocentro, na data: " ++ show dia ++ "."
   let comprovante = ComprovanteDoacao cpf texto

   addContent fileName $ show comprovante --Adiciona o objeto comprovante

 -- Retorna todos os comprovantes registrados no banco de dados
  getAllComprovantes :: String -> IO [String]
  getAllComprovantes = readContent

  getComprovanteByCpf:: String -> IO String
  getComprovanteByCpf fileName = do
    comprovanteToFind <- searchCpf

    getByContent fileName comprovanteToFind