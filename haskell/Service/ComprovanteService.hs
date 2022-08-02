module Service.ComprovanteService where

  import Model.ComprovanteDoacao
  import Util.ManagerTxt
  import Util.StringManager  
  import Data.Time

  fileNameComprovante :: String
  fileNameComprovante = "ComprovanteDoacao" 
  
 -- Registra um novo comprovante no sistema
 -- Parâmetros= fileName: o nome do aquivo onde será buscado o id,
 -- cpf: cpf da pessoa que realizou a doacao
 -- dia: o dia em que foi foito a doacao
 -- cria um comprovante de doacao
  createComprovante:: String -> Day -> IO()
  createComprovante cpf dia = do
   
   let texto = "Declaramos para os devidos fins e com agradecimentos que o(a) Sr(a), inscrito(a) no CPF sob o nº: " ++ cpf ++
        " , doou sangue/medula voluntariamente ao(à) Hemocentro, na data: " ++ show dia ++ "."
   let comprovante = ComprovanteDoacao cpf texto

   addContent fileNameComprovante $ show comprovante

  -- Retorna todos os comprovantes registrados no banco de dados
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o id
  -- Retorna um array com todas as pessoas do banco escolhido
  getAllComprovantes :: String -> IO [String]
  getAllComprovantes = readContent
