import System.IO
import Service.PersonService
import Service.DoacaoService
import Data.List
import Data.List.Split (splitOn)
import Util.ManagerTxt
import Data.Text (takeWhileEnd)
import Data.Time
import Service.ComprovanteService

fileNameDoadores :: String
fileNameDoadores = "Doadores"
-- fileNameReceptores = "Receptores"

fileNameDoacoes :: String
fileNameDoacoes = "Doacoes"

main :: IO ()
main = do

    -- CRIAR UM NOVO DOADOR
    -- createPerson fileNameDoadores

    -- -- BUSCAR TODOS OS DOADORES
    -- allContent <- getAllPersons fileName
    -- print allContent

    -- -- BUSCAR DOADOR POR CPF

    -- person <- getByCpf "Doadores"
    -- print person

    -- -- ATUALIZAR UM DOADOR

    -- personUpdated <- putByCpf fileDoadores
    -- print personUpdated

    -- -- DELETE UMA PESSOA

    -- deletePerson fileName


    -- -- CRIAR UMA NOVA DOACAO

    -- createDoacao fileNameDoacoes

    -- -- BUSCAR TODOS AS DOACOES

    -- allDoacoes <- getAllDoacoes fileNameDoacoes

    -- print allDoacoes

    -- BUSCA A DOACAO PELO ID

    -- doacao <- getDoacaoById fileNameDoacoes
    -- print doacao
    
    -- -- ATUALIZAR UMA DOACAO

    -- doacaoUpdated <- putById fileNameDoacoes
    -- print doacaoUpdated

    -- -- DELETAR UMA DOACAO

    -- removeById fileNameDoacoes

    -- comprov <- getComprovanteByCpf "ComprovanteDoacao"

    -- print comprov