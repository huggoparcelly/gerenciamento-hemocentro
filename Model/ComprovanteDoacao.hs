module Model.ComprovanteDoacao where
  data ComprovanteDoacao  = ComprovanteDoacao {
    cpf:: String,
    descricao:: String
  } deriving (Show, Read) 