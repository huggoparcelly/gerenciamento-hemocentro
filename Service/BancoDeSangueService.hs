module Service.BancoDeSangueService where

    import Model.BolsaSangue
    import Util.ManagerTxt

    --Registra uma nova bolsa no banco de dados, ainda falta implementar a função que gera o ID
    createBolsa:: String -> IO()
    createBolsa fileName = do
        putStr "Tipo sanguíneo: "
        tipo <- getLine
        
        let bolsa = BolsaSangue getLastId (fileName) tipo 450

        addContent fileName $ show bolsa
    
    --Retorna todas as bolsas de sangue registradas no sistema
    getAllBags:: String -> IO [String]
    getAllBags = readContent

    --Retorna uma bolsa em específico do banco de dados
    getBag:: String -> IO String
    getBag filename = do
        idToFind <- searchIdBag

        getById fileName idToFind
    
    searchIdBag:: IO String
    searchIdBag = do
        putStr "ID: "
        getLine
    
    --Deleta uma bolsa especificada pelo ID do banco de dados
    deleteBag:: String -> IO()
    deleteBag = do
        idToFind <- searchIdBag
        deleteById fileName idToFind