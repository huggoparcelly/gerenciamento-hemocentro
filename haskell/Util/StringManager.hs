{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Util.StringManager where

  import Data.List
  import System.IO
  import Prelude as P
  import Data.Time
  import Util.ManagerTxt
  

  -- Solicita ao usuario que digite um cpf(id) para ser buscado
  -- Retorna o cpf que foi digitado pelo usuario como string 
  searchCpf:: IO String
  searchCpf = do
    putStr "Cpf buscado: "
    getLine

  -- Busca o conteúdo que tem em uma linha em um arquivo txt
  -- Parâmetros= fileName: o nome do aquivo onde será buscado o conteúdo,
  --  str: "valor" a ser buscado pode ser CPF, id ou tipoSangue
  getByContent :: String -> String -> IO String
  getByContent filename str = do
    contentList <- readContent filename
    getByContentRecursivo contentList str

  -- Funcao recursiva que faz o loop para auxiliar na busca do conteudo
  -- Parâmetros= array de string, onde cada elemento do array será uma linha do txt,
  --  str: "valor" a ser buscado pode ser CPF, id ou tipoSangue
  -- Retorna uma string, com "Não encontrado" caso termine a iteração e não encontre o valor buscado
  -- ou com o conteudo buscado, no caso uma linha do txt
  getByContentRecursivo :: [String] -> String -> IO String
  getByContentRecursivo [] str =
    return "Não encontrado."
  getByContentRecursivo (d:ds) str =
    if checkIfExist str d then return d
    else getByContentRecursivo ds str


  -- Checa se o CPF, Id ou tipo de sangue passado na busca existe em um conteúdo
  -- Parâmetros= str: "valor" a ser buscado pode ser CPF, id ou tipoSangue
  -- content: conteudo a ser checado
  checkIfExist :: String -> String -> Bool
  checkIfExist str content
    | "id =" `isInfixOf` content =
      ("id = " ++ "\"" ++ str ++ "\"") `isInfixOf` content
    | "cpf =" `isInfixOf` content =
      ("cpf = " ++ "\"" ++ str ++ "\"") `isInfixOf` content
    | "tipoSangue =" `isInfixOf` content =
      ("tipoSangue = " ++ "\"" ++ str ++ "\"") `isInfixOf` content
    | otherwise = False


  -- Atualiza um conteudo em uma linha do txt, buscando pelo sua chave (id, cpf, tipoSangue).
  -- Primeiro realiza-se um busca do conteudo a ser modificado, através de um id, cpf ou tipo de sangue.
  -- Vai imprimir na tela caso nao encontre o conteudo a ser modificado
  -- Quando a modificação é permitida, busca um arrau com todo o do aquivo e faz-se a leitura do arquicom como um Handle
  -- Em seguida é feita a atualização e fechamento do Handle
  -- Parâmetros: fileName: o nome do aquivo onde será atualizado o conteúdo,
  -- str: "valor" a ser buscado pode ser CPF, id ou tipoSangue,
  -- modelUpdate: conteudo atualizado para ser insserido no txt
  updateByContent :: String -> String -> String -> IO()
  updateByContent fileName str modelUpdate = do
    model <- getByContent fileName str
    if model == "Não encontrado." then do putStr model
    else do
    allContent <- readContent fileName

    let path = "database/" ++ fileName ++ ".txt"
    fileHandle <- openFile path WriteMode

    updateByContentRecursivo allContent str modelUpdate fileHandle

    hFlush fileHandle
    hClose fileHandle



  -- Funcao recursiva que faz um loop para auxiliar a funcao updateByContent
  -- checa se existe o conteudo que sera atualizado
  -- caso o novo valor seja vazio a funcao só fará a chamada recursiva e nao sobreescre o conteudo que foi buscado (deletando o mesmo)
  -- na condicao se que exista um conteudo para atualizar, é feito a recursao e insere o conteudo atualizado no arquivo txt
  -- para os demais casos, em que a linha nao é o conteudo que deseja atualizar, apenas são inseridos no txt
  -- Parâmetros= (model:modelList): Um array de string que será perrido para chegar qual é a linha que será atualizada e sobreescrever as que não são para atualizar
  -- str: "valor" a ser buscado pode ser CPF, id ou tipoSangue,
  -- modelUpdate: conteudo atualizado para ser insserido no txt
  -- fileHandle: o arquivo txt lido como um Handle para facilitar a inserção e sobreescrita do conteudo
  updateByContentRecursivo :: [String] -> String -> String -> Handle -> IO ()
  updateByContentRecursivo [] str _ _ = return ()
  updateByContentRecursivo (model:modelList) str modelUpdate fileHandle = do
    if checkIfExist str model then do
      if modelUpdate == "" then do
        updateByContentRecursivo modelList str modelUpdate fileHandle
      else do
        hPutStrLn fileHandle modelUpdate
        updateByContentRecursivo modelList str modelUpdate fileHandle
    else do
      hPutStrLn fileHandle model
      updateByContentRecursivo modelList str modelUpdate fileHandle


  -- Funcao para deletar um conteudo do txt
  -- A função utilizarar do updateByContent passando como nova entrada uma string vazia
  -- Parametros= fileName: nome do arquivo que será feita a delecao
  -- str: "valor" a ser buscado para deleção, pode ser CPF, id ou tipoSangue,
  deleteByContent :: String -> String -> IO()
  deleteByContent fileName str = updateByContent fileName str ""