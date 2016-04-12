module Time(now) where

import Data.Time.LocalTime
import Data.Time.Format

now :: IO String
now = do
    zonedTime <- getZonedTime
    let localTime = zonedTimeToLocalTime zonedTime
    let date = localDay localTime
    let time = localTimeOfDay localTime
    let hour = todHour time
    let mint = todMin time
    let secn = floor $ todSec time
    return (show date ++ " " ++ show hour ++ ":" ++ show mint ++ ":" ++ show secn)