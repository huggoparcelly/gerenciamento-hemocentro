module Service.DoadorService where

  import Util.ManagerTxt
  import Model.Doador

  import Data.Time.Clock
  import Data.Time.Calendar
  import qualified Data.Functor
  import Data.List.Split

  fileDoadores :: String
  fileDoadores = "Doadores"

  -- adicionar novo doador
  createDoador :: String -> IO()
  createDoador Doador = do
    putStr "Cpf: "
    cpf <- getLine
    putStr "Nome: "
    nome <- getLine
    putStr "Telefone: "
    tel <- getLine
    putStr "Endereco: "
    endereco <- getLine
    putStr "Tipo Sanguineo: "
    tipoSangue <- getLine
    let doador = Doador cpf nome tel endereco tipoSangue

    addContent "Doadores" $ show doador

  -- listar doadores
  getAllDoadores :: String -> IO [String]
  getAllDoadores = readContent

  -- verificar existencia doador
  searchCpf :: IO String
  searchCpf = do
    putStr "Cpf buscado:"
    getLine

  getByCpf :: String -> IO String
  getByCpf "Doadores" = do
    cpfToFind <- searchCpf

    getPersonByCpf "Doadores" cpfToFind

  -- editar cadastro do doador
  putByCpf :: String -> IO ()
  putByCpf "Doadores" = do
    cpfToFind <- searchCpf

    putStr "Cpf: "
    cpf <- getLine
    putStr "Nome: "
    nome <- getLine
    putStr "Telefone: "
    tel <- getLine
    putStr "Endereco: "
    endereco <- getLine
    putStr "Tipo Sanguineo: "
    tipoSangue <- getLine

    let newDoador = Doador cpf nome tel endereco tipoSangue

    updatePersonByCpf "Doadores" cpfToFind $ show newDoador

  -- remover um doador
  deletePerson :: String -> IO ()
  deletePerson fileName = do
    cpfToFind <- searchCpf
    deletePersonByCpf "Doadores" cpfToFind