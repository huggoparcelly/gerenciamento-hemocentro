module Service.ComprovanteService where

  import Model.ComprovanteDoacao
  import Util.ManagerTxt
  import Util.StringManager  
  import Data.Time
  
  fileNameComprovante :: String
  fileNameComprovante = "ComprovanteDoacao" 

  
{-  Registra um novo comprovante de doação no sistema 
    Parametro = cpf: identificador do doador
                dia: data da doação
 -}
  createComprovante:: String -> Day -> IO()
  createComprovante cpf dia = do
   let texto = "Declaramos para os devidos fins e com agradecimentos que o(a) Sr(a), inscrito(a) no CPF sob o nº: " ++ cpf ++
        " , doou sangue/medula voluntariamente ao(à) Hemocentro, na data: " ++ show dia ++ "."
   let comprovante = ComprovanteDoacao cpf texto

   addContent fileNameComprovante $ show comprovante


{-  Busca todos os comprovantes registrados no banco de dados
    Retorno   = todos os comprovantes de doacções armazenados
-}
  getAllComprovantes :: IO [String]
  getAllComprovantes = readContent fileNameComprovante


{-  Busca um comprovante de doação pelo CPF do doador
    Captura as informações via console 
-}
  getComprovanteByCpf:: IO String
  getComprovanteByCpf = do
    comprovanteToFind <- searchCpf
    getByContent fileNameComprovante comprovanteToFind