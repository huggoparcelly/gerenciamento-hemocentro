module Service.BancoDeSangueService where

    import Model.BolsaSangue
    import Util.ManagerTxt
    import Util.ManagerId
    
    -- Registra uma nova bolsa no banco de dados, com quantidade zerada
    -- A medida que vão ocorrendo doações e transferencias de sangue o valor da quantidade é alterado. (put)
    createBolsa:: String -> IO()
    createBolsa fileName = do
        putStr "Tipo sanguíneo: "
        tipo <- getLine

        -- chama a funcao que incrementa o id
        id <- incrementaId fileName
        
        let bolsa = BolsaSangue id tipo 0

        addContent fileName $ show bolsa
    
    --Retorna todas as bolsas de sangue registradas no sistema
    getAllBags:: String -> IO [String]
    getAllBags = readContent

    --Retorna uma bolsa em específico do banco de dados
    getBag:: String -> IO String
    getBag fileName = do
        -- Chama a funcao de input que busca um id
        idToFind <- searchId
        getById fileName idToFind
    
    --Deleta uma bolsa especificada pelo ID do banco de dados
    deleteBag:: String -> IO()
    deleteBag fileName = do
        -- Chama a funcao de input que busca um id
        idToFind <- searchId
        deleteById fileName idToFind


    -- TODO fazer o put do banco de sangue para quando houver doação ou transferencia de sangue mudar a quantidade