import qualified Data.ByteString.Char8 as B
import Data.Tree.NTree.TypeDefs
import Data.Maybe
import Text.XML.HXT.Core
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Maybe
import Network.HTTP
import Network.URI
import System.Environment
import Control.Concurrent.ParallelIO

openUrl :: String -> MaybeT IO String
openUrl url = case parseURI url of
    Nothing -> fail "invalid URI"
    Just u  -> liftIO (getResponseBody =<< simpleHTTP (mkRequest GET u))
        
css :: ArrowXml a => String -> a XmlTree XmlTree
css tag = multi (hasName tag)

get_content :: String -> IO (IOSArrow XmlTree (NTree XNode))
get_content url = do
  contents <- runMaybeT $ openUrl url
  return $ readString [withParseHTML yes, withWarnings no] (fromMaybe "" contents)

images tree = tree >>> css "img" >>> getAttrValue "src"

parseArgs = do
  args <- getArgs
  mapM_ putStrLn args
  case args of
       (url:path:[]) -> return [url, path]
       otherwise -> error "incorrect command line arguments"

download storage_path url = do
  content <- runMaybeT $ openUrl url
  case content of
       Nothing -> return ()
       Just _content -> do
           let name = uriPath . fromJust . parseURI $ url
           let basename = reverse . takeWhile (/='/') . reverse $ name
           let path = storage_path ++ basename
           B.writeFile path (B.pack _content)

main = do
  [url, storage_path] <- parseArgs
  doc <- get_content url
  imgs <- runX . images $ doc
  parallel_ $ map (download storage_path) imgs
  stopGlobalPool

