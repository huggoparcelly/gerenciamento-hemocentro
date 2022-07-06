module Utils.CrudTxt where

  import Data.List.Split
  import System.IO

  -- add um conteudo em uma linha de um arquivo txt

  addContent :: String -> String -> IO()
  addContent fileName content = 
    appendFile ("database/" ++ fileName ++ ".txt") (content ++ "\n")

  -- ler todo conteudo de um txt e returna um array de string separados (splitOn) por linhas ("\n")
  readContent :: String -> IO [String]
  readContent fileName = do
    content <- openFile ("database/" ++ fileName ++ ".txt") ReadMode
    stringContent <- hGetContents content
    return (splitOn "\n" stringContent)

  -- buscar um conteúdo pelo id uma linha de um txt

  -- update de uma linha de um txt

  -- deletar uma linha em um txt
