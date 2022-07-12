module Service.ComprovanteService where

    import Model.ComprovanteDoacao
    import Utils.ManagerTxt

    --Registra um novo comprovante no sistema 
    createComprovante:: String -> IO()
    createComprovante = do
        putStr "Nome do doador: "
        nome <- getLine
        putStr "CPF do doador: "
        cpf <- getLine
        putStr "Data da doação: "
        dia <- getLine

        let comprovante = ComprovanteDoacao nome cpf dia 

        addContent fileName $ show comprovante
    
    --Retorna todos os comprovantes registrados no banco de dados
    getAllComprovantes:: String -> IO()
    getAllComprovantes = readContent

    searchCpf:: IO String
    searchCpf = do 
        putStr "Cpf doador: "
        getLine
    
    getComprovanteByCpf:: String -> IO String
    getComprovanteByCpf fileName = do
        comprovanteToFind <- searchCpf

        getComprovanteByCpf fileName comprovanteToFind
    


