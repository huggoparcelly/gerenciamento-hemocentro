module Model.Medula where
  import Data.Time

  data Medula  = Medula {
    id :: String,
    doador :: String,
    date :: Day -- :: (yyyy-mm-dd)
  } deriving (Show, Read)
