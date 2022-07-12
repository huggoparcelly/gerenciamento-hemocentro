module Model.Doador where
  data Doador  = Doador {
    cpf:: String,
    nome:: String,
    tel :: String,
    endereco:: String,
    tipoSangue:: String
  } deriving (Show, Read) 