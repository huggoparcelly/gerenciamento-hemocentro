module Model.Person where
  data Person  = Person {
    cpf:: String,
    nome:: String,
    tel :: String,
    endereco:: String,
    tipoSangue:: String
  } deriving (Show, Read) 
