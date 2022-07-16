module Menu where

import Service.DoacaoService (
 createDoacao,
 createDoacaoDirecionada,
 getAllDoacoes,
 getDoacaoById )
import Service.PersonService( 
 createPerson, 
 getAllPeople, 
 getByCpf, 
 putByCpf, 
 deletePerson )
import Util.ManagerTxt ()
import Model.BolsaSangue ()
import Model.ComprovanteDoacao ()
import Model.Doacao ()
import Model.Person ()
import Service.DoacaoMedulaService( 
 createDoacaoMedula, 
 getAllDoacoesMedula )
import Service.ComprovanteService (getAllComprovantes, getComprovanteByCpf)
        
menuPrincipal :: IO()
menuPrincipal = do
 putStrLn "\nPara cadastrar, digite 1;"
 putStrLn "\nPara editar, digite 2;"
 putStrLn "\nPara buscar, digite 3;"
 putStrLn "\nPara remover, digite 4;"
 putStrLn "\nPara listar, digite 5;"
 putStrLn "\nPara sair, digite 6;"

 opcao <- getLine
 putStr "\n"
 opcaoMenuPrincipal opcao

 if  opcao /= "6" then menuPrincipal
 else quit


quit:: IO()
quit = do
    putStrLn "Encerrando o sistema..."

opcaoMenuPrincipal :: String -> IO()
opcaoMenuPrincipal opcao
 | opcao == "1" = menuInputCadastro
 | opcao == "2" = menuInputEditar
 | opcao == "3" = menuInputBuscar
 | opcao == "4" = menuInputRemover
 | opcao == "5" = menuInputListar
 | opcao == "6" = sair
 | otherwise = do
 putStrLn "Insira um valor válido!\n"

menuInputCadastro :: IO ()
menuInputCadastro = do
 putStrLn "\n1 - Cadastrar novo Doador"
 putStrLn "\n2 - Cadastrar novo Receptor" 
 putStrLn "\n3 - Cadastrar nova Doacao"
 putStrLn "\n4 - Cadastrar nova Doacao Direcionada"
 putStrLn "\n5 - Cadastrar nova Doacao de Medula"
 putStrLn "\n6 - Voltar pro Menu Principal"

 opcao <- getLine
 putStr "\n"
 menuCadastrar opcao


menuCadastrar :: String -> IO()
menuCadastrar opcao
 
 | opcao == "1" =
 createPerson "Doadores"

 | opcao == "2" =
 createPerson "Receptores"

 | opcao == "3" =
 createDoacao "Doacoes"

 | opcao == "4" =
 createDoacaoDirecionada "Doacoes"

 | opcao == "5" =
 createDoacaoMedula "DoacoesMedula"

 | opcao == "6" = do
 menuPrincipal
 
 | otherwise = do
 putStrLn "Insira um valor válido!\n"
 menuInputCadastro

menuInputEditar :: IO ()
menuInputEditar = do
 putStrLn "\n1 - Editar Doador"
 putStrLn "\n2 - Editar Receptor" 
 putStrLn "\n3 - Voltar pro Menu Principal"

 opcao <- getLine
 putStr "\n"
 menuEditar opcao


menuEditar:: String -> IO()
menuEditar opcao

 | opcao == "1" =
 putByCpf "Doadores"

 | opcao == "2" =
 putByCpf "Receptores"

 | opcao == "3" =
 menuPrincipal

 | otherwise = do
 putStrLn "Insira um valor válido!\n"
 menuInputEditar

menuInputBuscar :: IO()
menuInputBuscar = do
 putStrLn "\n1 - Buscar Doador"
 putStrLn "\n2 - Buscar Receptor" 
 putStrLn "\n3 - Buscar Doacao"
 putStrLn "\n4 - Buscar Doacao de Medula"
 putStrLn "\n5 - Buscar Comprovante de Doacao por CPF"
 putStrLn "\n6 - Buscar Comprovante de Doacao de Medula por CPF"
 putStrLn "\n7 - Voltar pro Menu Principal"

 opcao <- getLine
 putStr "\n"
 menuBuscar opcao

menuBuscar :: String -> IO()
menuBuscar opcao

 | opcao == "1" = do
 resp <- getByCpf "Doadores"
 putStr resp

 | opcao == "2" = do
 resp <- getByCpf "Receptores"
 putStr resp

 | opcao == "3" = do
 resp <- getDoacaoById "Doacoes"
 putStr resp

 | opcao == "4" = do
 resp <- getDoacaoById "DoacoesMedula"
 putStr resp

 | opcao == "5" = do
 resp <- getComprovanteByCpf "ComprovanteDoacao"
 putStr resp

 | opcao == "6" = do
 resp <- getComprovanteByCpf "ComprovanteDoacao"
 putStr resp

 | opcao == "7" = do
 menuPrincipal

 | otherwise = do
 putStrLn "Insira um valor válido!\n"
 menuInputBuscar

menuInputRemover :: IO ()
menuInputRemover = do
 putStrLn "\n1 - Remover Doador"
 putStrLn "\n2 - Remover Receptor" 
 putStrLn "\n3 - Voltar pro Menu Principal"

 opcao <- getLine
 putStr "\n"
 menuRemover opcao

menuRemover:: String -> IO()
menuRemover opcao

 | opcao == "1" = do
 deletePerson "Doadores"

 | opcao == "2" = do
 deletePerson "Receptores"

 | opcao == "3" = do
 menuPrincipal

 | otherwise = do
 putStrLn "Insira um valor válido!\n"
 menuInputRemover

menuInputListar :: IO ()
menuInputListar = do
 putStrLn "\n1 - Listar Doadores"
 putStrLn "\n2 - Listar Receptores" 
 putStrLn "\n3 - Listar Doacoes"
 putStrLn "\n4 - Listar Doacoes de Medula"
 putStrLn "\n5 - Listar Comprovantes de Doacoes"
 putStrLn "\n6 - Voltar pro Menu Principal"

 opcao <- getLine
 putStr "\n"
 menuListar opcao

menuListar:: String -> IO()
menuListar opcao

 | opcao == "1" = do
 resp <- getAllPeople "Doadores"
 print resp

 | opcao == "2" = do
 resp <- getAllPeople "Receptores"
 print resp

 | opcao == "3" = do
 resp <- getAllDoacoes "Doacoes"
 print resp

 | opcao == "4" = do
 resp <- getAllDoacoesMedula "DoacoesMedula"
 print resp

 | opcao == "5" = do 
 resp <- getAllComprovantes "ComprovanteDoacao"
 print resp

 | opcao == "6" = do
 menuPrincipal

 | otherwise = do
 putStrLn "Insira um valor válido!\n"
 menuInputListar

sair :: IO()
sair = do
 putStrLn "Sair"