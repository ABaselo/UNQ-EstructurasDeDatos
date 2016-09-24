indiceDe :: Eq a => [a] -> Int -> Maybe a
indiceDe [] _ = Nothing
indiceDe (x:xs) 0 = Just x
indiceDe (x:xs) n =	indiceDe xs (n-1)

