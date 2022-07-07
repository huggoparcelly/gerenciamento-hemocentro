module Models.Doacao where
  data Doacao  = Doacao {
    id:: Int,
    doador:: Pessoa,
    tipoSangue:: String,
    quantidade:: Int,
    data:: DateTime
  } deriving (Show, Read)


