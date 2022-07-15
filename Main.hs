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
import Model.BolsaSangue (BolsaSangue(BolsaSangue, quantidade))
import Util.StringManager
import Model.Person
import Text.Read (Lexeme(String))
import Model.Doacao (Doacao(Doacao))
import Service.DoacaoService
import Util.IdManager

fileDoadores :: String
fileDoadores = "Doadores"
-- fileNameReceptores = "Receptores"

fileDoacoes :: String
fileDoacoes = "Doacoes"

fileBolsas :: String
fileBolsas = "BolsaSangue"

main :: IO ()
-- main = do
--     retorno <- createComprovante createComprovante ComprovanteDoacao.txt getLastId (ComprovanteDoacao.txt) cpf dateNow
--     putStr retorno
    -- createDoacaoDirecionada fileDoacoes
    -- putStr "Tipo de sangue: "
    -- tipo <- getLine
    -- linhaBolsa <- getByContent fileBolsas "A+" 
    -- print linhaBolsa
    -- qtdOld <- getQtdFromBolsas linhaBolsa
    -- print qtdOld
    -- linhaBolsa <- getByContent fileNameBolsas tipo 
    -- retorno <- removeCharacters linhaBolsa
    -- print retorno
    -- print linhaBolsa
    -- test <- getDoacaoById  fileDoacoes

    -- let dropElements = dropWhile (/= '=') a -- dropa os caracteres até o = ("= ID, ...")
    -- let takeElement = takeWhile (/= ',') dropElements -- retorna os caracteres até a , ("= ID")
    -- let getId = words takeElement 
    -- let idStr = last getId

    -- print (idStr!!1)

    -- let drops = dropWhile (/= '=') test
    -- let drops2 = takeWhile (/= ',') drops
    -- let getW = words drops2
    -- let lastW = last getW
    -- let a = dropWhile (== '\"') lastW
    -- let b = takeWhile (/= '\"') a
    -- print (read b :: Int)

    -- let dropElements = dropWhile (/= '=') linhaBolsa
    -- print dropElements
    -- let takeElement = takeWhile (/= '}') dropElements
    -- print takeElement
    -- let getId = words takeElement
    -- print (last getId)

    -- retorno <- removeCharactersToId linhaBolsa
    -- print retorno


    -- let dropElements = dropWhile (/= '=') element -- dropa os caracteres até o = ("= ID, ...")
    -- let takeElement = takeWhile (/= '}') dropElements -- retorna os caracteres até a , ("= ID")
    -- let getId = words "= "  -- faz um split do "= ID" (["", "ID"])
    -- let idStr = last getId


    -- INCREMENTAR QUANTIDADE DE BOLSA
    -- bolsa <- getByContent fileNameBolsas "A+"
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