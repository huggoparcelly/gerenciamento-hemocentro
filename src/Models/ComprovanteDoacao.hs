module Models.ComprovanteDoacao where
  data ComprovanteDoacao  = ComprovanteDoacao {
    id:: Int,
    doador:: String,
    tipoSangue:: String,
    descricao:: String
  } deriving (Show, Read) 