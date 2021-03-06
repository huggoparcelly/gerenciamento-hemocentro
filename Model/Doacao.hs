module Model.Doacao where
  import Data.Time

  data Doacao  = Doacao {
    id :: String,
    doador :: String,
    tipoSangue :: String,
    quantidade :: Int,
    date :: Day -- :: (yyyy-mm-dd)
  } deriving (Show, Read)


