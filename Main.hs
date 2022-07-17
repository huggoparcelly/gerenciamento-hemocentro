import System.IO
import Util.ManagerTxt ( welcomeScreen )
import Menu ( menuPrincipal )

main :: IO ()

main = do
    putStrLn welcomeScreen 
    menuPrincipal