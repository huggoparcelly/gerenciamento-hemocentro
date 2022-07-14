import System.IO
-- import Service.PersonService
-- import Service.DoacaoService
import Data.List
-- import Data.List.Split (splitOn)
import Util.ManagerTxt
import Data.Text (takeWhileEnd)
import Data.Time
-- import Service.ComprovanteService
import Service.BancoDeSangueService
import Model.BolsaSangue (BolsaSangue(BolsaSangue))
import Util.StringManager
import Model.Person
import Text.Read (Lexeme(String))
import Model.Doacao (Doacao(Doacao))
import Service.DoacaoService

fileNameDoadores :: String
fileNameDoadores = "Doadores"
-- fileNameReceptores = "Receptores"

fileNameDoacoes :: String
fileNameDoacoes = "Doacoes"

fileNameBolsas :: String
fileNameBolsas = "BolsaSangue"

main :: IO ()
main = do

    -- INCREMENTAR QUANTIDADE DE BOLSA
    -- bolsa <- getByTipo fileNameBolsas "A+"
    -- putStr bolsa

    -- let person = Person "12345" "Mari"
    -- let bolsaSangue = BolsaSangue "A+" 2
    -- bolsa <- updateByTipo fileNameBolsas "A+" $show bolsaSangue
    -- print bolsa

    -- let teste1 = Doacao "10" "Mari"
    -- test <- readContent fileNameDoacoes 
    -- test <- getByContent fileNameDoacoes "5"
    -- test <- updateByContent fileNameDoacoes "5" $show teste1
    -- test <- createDoacao fileNameDoacoes
    -- print test

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