module Model.Pessoa where
  data Pessoa  = Pessoa {
    cpf:: String,
    nome:: String,
    tel :: String,
    endereco:: String,
    tipoSangue:: String
  } deriving (Show, Read) 
