module Model.BolsaSangue where
  data BolsaSangue  = BolsaSangue {
    id:: Int,
    tipoSangue:: String,
    quantidade:: Int
  } deriving (Show, Read) 