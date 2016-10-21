module Multiset(Multiset, emptyMS, occursMS, addMS, removeMS, unionMS, intersectMS) where

import Map
import Maybe

data Multiset a = MkMS (Map a Int)
-- Inv. Rep.:
-- Los valores del map son mayores a 0

-- Crea un multiset
emptyMS :: Multiset a -- O(1)
emptyMS = MkMS emptyM

-- Devuelve la cantidad de apariciones 
-- de un elemento
occursMS :: Ord a => a -> Multiset a -> Int -- O(n)
occursMS x (MkMS m) = lookupInt x m

-- Añade una aparición de un elemento
addMS :: Ord a => a -> Multiset a -> Multiset a -- O(n)
addMS x (MkMS m) = MkMS (addOccurs x m)

-- Decrementa la cantidad de apariciones de un elemento
removeMS :: Ord a => a -> Multiset a -> Multiset a --O(n)
removeMS x (MkMS m) = MkMS (removeOccurs x m)

--- TAREA

-- Une dos multiset (suma las ocurrencias de cada elemento 
-- entre ambos multiset)
unionMS :: Ord a => Multiset a -> Multiset a -> Multiset a
unionMS (MkMS m1) (MkMS m2) = undefined

-- Se queda con la mínima ocurrencia de cada elemento entre dos multiset
-- (observación: si un elemento no ocurre en uno de los multiset
-- entonces no aparece en el resultado)
intersectMS :: Ord a => Multiset a -> Multiset a -> Multiset a
intersectMS (MkMS m1) (MkMS m2) = undefined

-------------------------------------------------------

maybeToInt :: Maybe Int -> Int
maybeToInt Nothing  = 0
maybeToInt (Just n) = n

lookupInt :: Ord a => a -> Map a Int -> Int
lookupInt x m = maybeToInt (lookupM x m) 

addOccurs :: Ord a => a -> Map a Int -> Map a Int 
addOccurs x m =
	assocM x ((lookupInt x m) + 1) m

removeOccurs :: Ord a => a -> Map a Int -> Map a Int
removeOccurs x m =
	unaOccurMenos x (lookupInt x m) m

unaOccurMenos :: Ord a => a -> Int -> Map a Int -> Map a Int
unaOccurMenos x 0    m = m
unaOccurMenos x 1    m = removeM x m
unaOccurMenos x n    m = assocM x (n-1) m
