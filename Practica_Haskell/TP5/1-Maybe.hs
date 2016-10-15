import Maybe
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

--(1).-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

init2 :: [a] -> [a]
init2 (e:[]) = []
init2 (e:es) = e:init2 es

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

last2 :: [a] -> a
last2 (e:[]) = e
last2 (e:es) = last2 es

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

indiceDe :: Eq a => a -> [a] -> Int
indiceDe x (e:es) =	if x == e
					then 1
					else 1 + indiceDe x es

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
					
valorParaClave :: Eq k => [(k,v)] -> k -> v
valorParaClave ((k2,v):cs) k =	if k == k2
								then v
								else valorParaClave cs k
								
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
								
maximum2 :: Ord a => [a] -> a
maximum2 (e:[]) = e
maximum2 (e:es) =	if e > maximum2 es
					then e
					else maximum2 es

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
					
minT :: Ord a => Tree a -> a
minT (NodeT e EmptyT EmptyT) =	e
minT (NodeT e EmptyT t) =	if e < minT t
							then e
							else minT t
minT (NodeT e t EmptyT) =	if e < minT t
							then e
							else minT t
minT (NodeT e t1 t2) =	if e < minT t1
						then	if e < minT t2
								then e
								else minT t2
						else	if minT t1 < minT t2
								then minT t1
								else minT t2
								
--(2).-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--O(1)
initMaybe :: [a] -> Maybe [a]
initMaybe [] = Nothing
initMaybe (e:[]) = Just []
initMaybe (e:es) = Just (e:(fromJust (initMaybe es)))

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--O(1)
lastMaybe :: [a] -> Maybe a
lastMaybe [] = Nothing
lastMaybe (e:[]) = Just e
lastMaybe (e:es) = lastMaybe es

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--O(n)
indiceDeMaybe :: Eq a => a -> [a] -> Maybe Int
indiceDeMaybe x elems = buscarIndiceEnLs x elems 0

buscarIndiceEnLs :: Eq a => a -> [a] -> Int -> Maybe Int
buscarIndiceEnLs _ [] _ = Nothing
buscarIndiceEnLs x (elem:elems) indice =	if elem == x
											then Just (indice+1)
											else buscarIndiceEnLs x elems (indice+1)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--O(n)
valorParaClaveMaybe :: Eq k => [(k,v)] -> k -> Maybe v
valorParaClaveMaybe [] _ = Nothing
valorParaClaveMaybe ((k2,v):cs) k =		if k == k2
										then Just v
										else valorParaClaveMaybe cs k
								
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--O(n)?
maximumMaybe :: Ord a => [a] -> Maybe a
maximumMaybe [] = Nothing
maximumMaybe (e:[]) = Just e
maximumMaybe (e:es) =	let maximo = fromJust (maximumMaybe es)
						in	
							if e > maximo
							then Just e
							else Just maximo

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
					
--O(n)
--En EjemplosMaybe.hs hay una forma más prolija de resolver este ejercicio.
minTMaybe :: Ord a => Tree a -> Maybe a
minTMaybe EmptyT = Nothing
minTMaybe (NodeT e EmptyT EmptyT) =	Just e
minTMaybe (NodeT e EmptyT t) =	if e < fromJust (minTMaybe t)
								then Just e
								else minTMaybe t
minTMaybe (NodeT e t EmptyT) =	if e < fromJust (minTMaybe t)
								then Just e
								else minTMaybe t
minTMaybe (NodeT e t1 t2) =	if e < fromJust (minTMaybe t1)
							then	if e < fromJust (minTMaybe t2)
									then Just e
									else minTMaybe t2
							else	if fromJust (minTMaybe t1) < fromJust (minTMaybe t2)
									then minTMaybe t1
									else minTMaybe t2
								
