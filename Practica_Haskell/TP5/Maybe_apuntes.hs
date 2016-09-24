--Maybe
-------

--Maybe ya está definido en Haskell.
data Maybe a = Nothing | Just a

--Utilizo Maybe en minL para salvar el caso el donde minL es parcial en lista vacía.
minL :: [a] -> Maybe a
minL [] = Nothing
minL (x:xs) = minMaybe x (minL xs)

minMaybe :: a -> Maybe a -> Maybe a
minMaybe x Nothing = Just x
minMaybe x (Just y) = Just (min x y)

--Parcial en arbol vacío.
minT :: Tree a -> a
minT (NodeT x Empty Empty) = x
minT (NodeT x Empty t2) = min x (minT t2)
minT (NodeT x t2 Empty) = min x (minT t1)
minT (NodeT x t1 t2) = min x (min (minT t1) (minT t2))

--minT :: Tree a -> Maybe a
--minT EmptyT = x
--minT (NodeT x t1 t2) = minMaybe (minT t1) (minT t2)

minMaybe :: Ord a => a -> Maybe a -> Maybe a -> Maybe a
--minMaybe Nothing Nothing = Nothing
--minMaybe Nothing (Just y) = Just y
--minMaybe (Just x) Nothing = Just x
minMaybe Nothing y = x
minMaybe x Nothing = y
minMaybe (Just x) (Just y) = Just (min x y)

minL :: [a] -> Maybe a
minL [] = Nothing
minL (x:xs) = minMaybe (Just x) (minL xs)

minT EmptyT = Nothing
minT (NodeT x t1 t2) = minMaybe (Just x) (minMaybe (minT t1) (minT t2))

-------------------------------------------------
--Ejercitacion:
--	init2 :: [a] -> [a]
--	last2 :: [a] -> a
--	indiceDe :: Eq a => [a] -> a -> Int


--Sin Maybe
-----------

--Prec.: Parcial en lista vacía.
init2 :: [a] -> [a]
init2 [x] = []
init2 (x:xs) = x : init2 xs

--Con Maybe
-----------

init2 :: [a] -> Maybe [a]
init2 [] = Nothing
init2 [x] = Just []
init2 (x:xs) = aMaybeL x (init2 xs)

aMaybeL :: a -> Maybe [a] -> Maybe [a]
aMaybeL x (Just xs) = Just (x:xs)
aMaybeL x Nothing = Just [x]

--Sin Maybe
-----------

--Prec.: Parcial en lista vacía.
last2 :: [a] -> a
last2 [] = error "Parcial en lista vacía"
last2 [x] = x
last2 (x:xs) = last2 xs

--Con Maybe
-----------

last2 :: [a] -> Maybe a
last2 [] = Nothing
last2 [x] = Just x
last2 (x:xs) = last2 xs


--Este no es el enunciado del ejercicio.
----------------------------------------
--Sin Maybe
-----------

--Prec.: Parcial en lista vacía.
indiceDe :: Eq a => [a] -> Int -> a
indiceDe [] n = error "No existe la posición en la lista."
indiceDe (x:xs) 0 = x
indiceDe (x:xs) n =	indiceDe xs (n-1)


--Con Maybe
-----------

indiceDe :: Eq a => [a] -> Int -> Maybe a
indiceDe [] _ = Nothing
indiceDe (x:xs) 0 = Just x
indiceDe (x:xs) n =	indiceDe xs (n-1)
 
-----------------------------------------

