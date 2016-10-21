import Map
import Set
import Maybe

data MultiSet a = MkMS (Map a Int)

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--Crea un multiconjunto vacı́o.
emptyMSet :: MultiSet a
emptyMSet = MkMS emptyM

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--Dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al multiconjunto.
addMS :: Ord a => a -> MultiSet a -> MultiSet a
addMS e (MkMS m) = MkMS (assocM m e ((lookupInt m e) + 1) )


-- /* f auxiliares --

lookupInt :: Eq a => Map a Int -> a -> Int
lookupInt m e = maybeToInt (lookupM m e)

maybeToInt :: Maybe Int -> Int
maybeToInt Nothing = 0
maybeToInt (Just n) = n

-- FIN f auxiliares */ --

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--Dados un elemento y un multiconjunto indica la cantidad de apariciones de ese elemento en el multiconjunto.
ocurrencesMS :: Ord a => a -> MultiSet a -> Int
ocurrencesMS e (MkMS m) = lookupInt m e

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--Dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de ambos multiconjuntos.
unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
unionMS (MkMS m1) (MkMS m2) = MkMS (unionMaps m1 m2)


-- /* f auxiliares --

unionMaps :: Ord k => Map k Int -> Map k Int -> Map k Int
unionMaps m1 m2 = unionRecursivaDeMaps (claves m1) m1 m2


unionRecursivaDeMaps :: Ord k => [k] -> Map k Int -> Map k Int -> Map k Int
unionRecursivaDeMaps [] _ m2 = m2
unionRecursivaDeMaps (k:ks) m1 m2 =
	let	vm1 = lookupInt m1 k	-- vm1 /= 0
		vm2 = lookupInt m2 k	-- (vm2 /= 0) || (vm2 == 0)
	in
		unionRecursivaDeMaps ks m1 (assocM m2 k (vm1 + vm2))
		

claves :: Ord k => Map k v -> [k]
claves map = setToList (domM map)


extraerValor :: Eq k => Map k v -> k -> v
extraerValor map k = fromJust (lookupM map k)

-- FIN f auxiliares */--

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--Dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos multiconjuntos tienen en común.
intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
intersectionMS (MkMS map) ms = MkMS (intersectionMapMS map ms)


-- /* f aux: --

intersectionMapMS :: Ord k => Map k Int -> MultiSet k -> Map k Int
intersectionMapMS map ms = intersectionRecursivaMapMS (claves map) map ms


intersectionRecursivaMapMS :: Ord k => [k] -> Map k Int -> MultiSet k -> Map k Int
intersectionRecursivaMapMS [] map _ = map
intersectionRecursivaMapMS (k:ks) map ms = 
		let	ocms = ocurrencesMS k ms
		in
			if ocms > 0
			then intersectionRecursivaMapMS ks (assocM map k (lookupInt map k + ocms)) ms
			else intersectionRecursivaMapMS ks (deleteM map k) ms
			
-- FIN f auxiliares */--

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--Dado un multiconjunto devuelve una lista con todos los elementos del conjunto y su cantidad de ocurrencias.
multiSetToList :: Ord a => MultiSet a -> [(Int,a)]
multiSetToList (MkMS map) = mapToList map


-- /* f auxiliares: --

mapToList :: Ord k => Map k Int -> [(Int,k)]
mapToList map = mapToListRecursivo (claves map) map


mapToListRecursivo :: Ord k => [k] -> Map k Int -> [(Int,k)]
mapToListRecursivo [] _ = []
mapToListRecursivo (k:ks) map = ((lookupInt map k),k) : mapToListRecursivo ks map

-- FIN f auxiliares */ --
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
