module Service.ComprovanteService where

 import Model.ComprovanteDoacao
 import Util.ManagerTxt
 import Util.IdManager
--  import Service.DoacaoService (getDoacaoById)
 import Util.StringManager  
 import Data.Time
  
 --Registra um novo comprovante no sistema 
 createComprovante:: String -> String -> Day -> IO()
 createComprovante fileName cpf data = do
   -- TODO
   -- quando acontecer a doação (create doacao) retornar um id
   -- getDoacaoById - tratar a string para capturar nome, cpf, tipo sanguineo e data de doacao
   -- preencher o descritivo "Declaramos para os devidos fins e com agradecimentos que o(a) 
   -- Sr(a) (nome), inscrito(a) no CPF sob o nº (informar), doou sangue voluntariamente ao(à) (Hemocentro), às (horário) do dia (data)."
   -- criar o comprovante de doacao
   -- doacao <- getDoacaoById "Doacoes"
   let texto = "Declaramos para os devidos fins e com agradecimentos que o(a) Sr(a), inscrito(a) no CPF sob o nº: " ++ cpf ++
     " , doou sangue voluntariamente ao(à) Hemocentro, na data: " ++ data ++ "."
   let comprovante = ComprovanteDoacao cpf texto

   addContent fileName $ show comprovante --Adiciona o objeto comprovante
   addContent fileName $ "Declaramos para os devidos fins e com agradecimentos que o(a) Sr(a), inscrito(a) no CPF sob o nº: " ++ cpf ++
     " , doou sangue voluntariamente ao(à) Hemocentro, na data: " ++ data ++ "." 

 -- Retorna todos os comprovantes registrados no banco de dados
 getAllComprovantes :: String -> IO [String]
 getAllComprovantes = readContent

 getComprovanteByCpf:: String -> IO String
 getComprovanteByCpf fileName = do
   comprovanteToFind <- searchCpf

   getByContent fileName comprovanteToFind