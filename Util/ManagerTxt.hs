module Util.ManagerTxt where

  import Data.List
  import System.IO
  import Prelude as P
  import Control.Exception (evaluate)
  import Data.Time
  
  -- Funcao para add um conteudo em um arquivo txt a partir do seu nome
  -- Parametros: nome do arquivo, conteudo
  addContent :: String -> String -> IO()
  addContent fileName content = do
    let newContent = content ++ "\n"
    appendFile ("database/" ++ fileName ++ ".txt") newContent


  -- Funcao que ler todo conteudo de um txt e returna um array de string separados (splitOn) por linhas ("\n")
  -- Parametros: nome do arquivo
  readContent :: String -> IO [String]
  readContent fileName = do
      content <- openFile ("database/" ++ fileName ++ ".txt") ReadMode
      stringContent <- hGetContents content
      evaluate (P.length stringContent)
      return (P.lines stringContent)

  -- Função que retorna a data de uma doação no formato (ano-mês-dia).
  -- Parâmetros: Doação. A partir dela que é retornada a data.
  getDate :: ParseTime t => [Char] -> t
  getDate doacao = do

    let split = words "date = "
    let lastElement = last split
    let date = takeWhile (/= '}') lastElement

    let parse = parseTimeOrError True defaultTimeLocale "%Y-%-m-%-d" date
    parse
  
  --Funcao que exibe um banner de boas vindas ao usuário. 
  --Parametros: Essa função não recebe parâmetros.
  welcomeScreen:: String
  welcomeScreen = "######\n" ++
      "#     # ###### #    #    #    # # #    # #####   ####       ##    ####\n" ++
      "#     # #      ##  ##    #    # # ##   # #    # #    #     #  #  #    #\n" ++
      "######  #####  # ## #    #    # # # #  # #    # #    #    #    # #    #\n" ++
      "#     # #      #    #    #    # # #  # # #    # #    #    ###### #    #\n" ++ 
      "#     # #      #    #     #  #  # #   ## #    # #    #    #    # #    #\n" ++
      "######  ###### #    #      ##   # #    # #####   ####     #    #  ####\n" ++

    "#     #                                                               ###\n" ++
    "#     # ###### #    #  ####   ####  ###### #    # ##### #####   ####  ###\n" ++
    "#     # #      ##  ## #    # #    # #      ##   #   #   #    # #    # ###\n" ++
    "####### #####  # ## # #    # #      #####  # #  #   #   #    # #    #  #\n" ++
    "#     # #      #    # #    # #      #      #  # #   #   #####  #    #\n" ++
    "#     # #      #    # #    # #    # #      #   ##   #   #   #  #    # ###\n" ++
    "#     # ###### #    #  ####   ####  ###### #    #   #   #    #  ####  ###\n"


