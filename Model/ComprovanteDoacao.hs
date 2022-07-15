module Model.ComprovanteDoacao where
  data ComprovanteDoacao  = ComprovanteDoacao {
    cpf:: String,
    data:: String
  } deriving (Show, Read) 