module Menu where

import Service.DoacaoService
import Service.PersonService
import Util.ManagerTxt
import Model.BolsaSangue
import Model.ComprovanteDoacao
import Model.Doacao
import Model.Person

menuPrinciapal :: IO()
menuPrinciapal = do
    putStrLn "\nBem vindo Gerenciamento de Hemocentro"
    putStrLn "\nPara cadastrar, digite 1;"
    putStrLn "\nPara editar, digite 2;"
    putStrLn "\nPara buscar, digite 3;"
    putStrLn "\nPara remover, digite 4;"
    putStrLn "\nPara listar, digite 5;"

opcaoMenuPrincipal :: String -> IO()
opcaoMenuPrincipal opcao
    | opcao == "1" = menuCadastrar
    | opcao == "2" = menuEditar
    | opcao == "3" = menuBuscar
    | opcao == "4" = menuRemover
    | opcao == "5" = menuListar
    | otherwise = do
        putStrLn "Insira um valor válido!\n"
        menuPrincipal

menuCadastrar :: String -> IO()
menuCadastrar = do
    putStrLn "\n1 - Cadastrar novo Doador"
    putStrLn "\n2 - Cadastrar novo Receptor" 
    putStrLn "\n3 - Cadastrar nova Doacao"
    putStrLn "\n4 - Cadastrar nova Doacao Direcionada"
    putStrLn "\n5 - Cadastrar nova Doacao de Medula"
    putStrLn "\n6 - Voltar pro Menu Principal"

    opcao <- getLine
    putStr "\n"
    
    if opcao == "1" then do
        doador <- createPerson
        let doador = Person cpf name
        addContent fileDoador $ show doador 
    else if opcao == "2" then do
        receptor <- createPerson
        let receptor = Person cpf name
        addContent fileReceptor $ show receptor 

    else if opcao == "3" then do
        doacao <- createDoacao

    else if opcao == "4" then do
        doacao <- createDoacaoDirecionada

    else if opcao == "5" then do
        doacao <- createDoacao

    else if opcao == "6" then do
        menuPrincipal
    
    else if otherwise then do
        putStrLn "Insira um valor válido!\n"
        menuCadastrar

menuEditar:: String -> IO()
menuEditar = do
    putStrLn "\n1 - Editar Doador"
    putStrLn "\n2 - Editar Receptor" 
    putStrLn "\n3 - Voltar pro Menu Principal"
    opcao <- getLine
    putStr "\n"

    | opcao == "1" = do
        cpf <- putByCpf 
        
    | opcao == "2" = do
        cpf <- putByCpf

    | opcao == "3" = do
        menuPrincipal

    | otherwise = do
        putStrLn "Insira um valor válido!\n"
        menuEditar

menuBuscar:: String -> IO()
menuBuscar = do
    putStrLn "\n1 - Buscar Doador"
    putStrLn "\n2 - Buscar Receptor" 
    putStrLn "\n3 - Buscar Doacao"
    putStrLn "\n4 - Buscar Doacao de Medula"
    putStrLn "\n5 - Voltar pro Menu Principal"
    opcao <- getLine
    putStr "\n"

    | opcao == "1" = do
        cpf <- getByCpf
        
    | opcao == "2" = do
        cpf <- getByCpf

    | opcao == "3" = do
        id <- getById

    | opcao == "4" = do
        id <- getById

    | opcao == "5" = do
        menuPrincipal

    | otherwise = do
        putStrLn "Insira um valor válido!\n"
        menuBuscar

menuRemover:: String -> IO()
menuRemover = do
    putStrLn "\n1 - Remover Doador"
    putStrLn "\n2 - Remover Receptor" 
    putStrLn "\n3 - Voltar pro Menu Principal"
    opcao <- getLine
    putStr "\n"

    | opcao == "1" = do
        cpf <- deletePerson
        
    | opcao == "2" = do
        cpf <- deletePerson

    | opcao == "3" = do
        menuPrincipal

    | otherwise = do
        putStrLn "Insira um valor válido!\n"
        menuRemover

menuListar:: String -> IO()
menuListar = do
    putStrLn "\n1 - Listar Doadores"
    putStrLn "\n2 - Listar Receptores" 
    putStrLn "\n3 - Listar Doacoes"
    putStrLn "\n4 - Listar Doacoes de Medula"
    putStrLn "\n5 - Listar Comprovante de Doacoes"
    putStrLn "\n6 - Listar Comprovante de Doacoes de Medula"
    putStrLn "\n7 - Voltar pro Menu Principal"
    opcao <- getLine
    putStr "\n"

    | opcao == "1" = do
        getAllDoadores
                    
    | opcao == "2" = do
        getAllReceptores
        
    | opcao == "3" = do
        getAllDoacoes

    | opcao == "4" = do
        getAllDoacoesMedula

    | opcao == "5" = do
        getAllComprovanteDoacoes

    | opcao == "6" = do
        getAllComprovanteDoacoesMedula     

    | opcao == "7" = do
        menuPrincipal

    | otherwise = do
        putStrLn "Insira um valor válido!\n"
        menuListar        