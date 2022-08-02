module Model.BolsaSangue where
  data BolsaSangue  = BolsaSangue {
    tipoSangue:: String,
    quantidade:: Int
  } deriving (Show, Read) 