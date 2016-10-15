
import Set
--(2).-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

data Map k v = MkM [(k,v)]

--Retorna un Map vacío
emptyM :: Map k v

--Retorna el Map dado como parámetro con el par ordenado clave valor dados agregado.
assocM :: Eq k => Map k v -> k -> v -> Map k v

--Dada una clave retorna el valor asociado a este.
lookupM :: Eq k => Map k v -> k -> Maybe v

--Retorna el Map dado como parámetro con el par ordenado clave valor dados eliminado.
deleteM :: Eq k => Map k v -> k -> Map k v

--Retorna un Set de las claves del Map.
domM :: Ord k => Map k v -> Set k

-- *******************
--  IMPLEMENTACIONES:
-- *******************

--1) Implementación como una lista de pares clave-valor con claves repetidas.

--O(1)
emptyM = MkM []

--O(1)
--assocM (MkM ps) k v = MkM ((k,v):ps)


--O(n)					
lookupM (MkM []) _ = Nothing
lookupM (MkM ((k,v):ps)) clave =	if k == clave
									then Just v
									else lookupM (MkM ps) clave

--O(n)									
deleteM (MkM ps) clave = MkM (deleteParConClave clave ps)

--O(n)													
domM (MkM ps) = obtenerClaves ps



--2) Implementación como una lista de pares clave-valor sin claves repetidas.

--O(n)
assocM (MkM ps) k v = MkM (agregarPar (k,v) ps)


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-- FUNCIONES AUXILIARES:
-- --------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--O(n)
--(i) Si lo encuentra lo agregar; si hay lista vacía después del recorrido significa que no lo encontró y lo agrega. OJO con no mutilar la lista. Mirar then y else.
agregarPar :: Eq k => (k,v) -> [(k,v)] -> [(k,v)]
agregarPar (k,v) [] = [(k,v)]
agregarPar (k,v) ((k2,v2):ps) =	if k == k2
								then (k,v):ps
								else (k2,v2):agregarPar (k,v) ps

--agregarAlFinal :: (k,v) -> [(k,v)] -> [(k,v)]
--agregarAlFinal (k,v) [] = [(k,v)]
--agregarAlFinal (k,v) (p:ps) = p:agregarAlFinal (k,v) ps

--O(n)
deleteParConClave :: Eq k => k -> [(k,v)] -> [(k,v)]
deleteParConClave _ [] = []
deleteParConClave clave ((k,v):ps) =	if clave /= k
										then (k,v):deleteParConClave clave ps
										else deleteParConClave clave ps
										
obtenerClaves :: Ord k => [(k,v)] -> Set k
obtenerClaves [] = emptySet
obtenerClaves ((k,_):ps) = add k (obtenerClaves ps)


ejMap :: Map Int Char
ejMap = MkM [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e'),(6,'f')]
