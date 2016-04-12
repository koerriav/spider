module Parser where

import Text.HTML.TagSoup
import Text.Regex.TDFA.String(regexec,Regex)
import Text.Regex.Base.RegexLike(makeRegex)
import Data.Set(toList,fromList)

baseUrl = "http://www.ygdy8.net"

getUrl :: String -> [String]
getUrl str = map (baseUrl++) $ filter (like "^/html/.+") $ unique $ map (\attrs -> fromAttrib "href" attrs) $ filter isTagOpen $ parseTags str

fetchFtp :: String -> [String]
fetchFtp str = filter (like "^ftp://.+") $ unique $ map (\attrs -> fromAttrib "href" attrs) $ filter isTagOpen $ parseTags str

like :: String -> String -> Bool
like regex str = case regexec (makeRegex regex::Regex) str of
    Right Nothing -> False
    Right _  -> True
    Left _ -> False
unique :: Ord a => [a] -> [a]
unique = toList . fromList
