import Map
import Maybe

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--1)

indexar :: [a] -> Map Int a
indexar ls = indexarEnMap emptyM ls 0

-- f aux: --

indexarEnMap :: Map Int a -> [a] -> Int -> Map Int a
indexarEnMap map [] _ = map
indexarEnMap map (e:es) n =
					indexarEnMap (assocM map n e) es (n+1)
					
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--2)

pedirTelefonos :: [String] -> Map String Int -> [Maybe Int]
pedirTelefonos [] _ = []
pedirTelefonos (n:ns) map = lookupM map n : pedirTelefonos ns map

-- ej.: --

ejTel :: Map String Int
ejTel = assocM (assocM (assocM (assocM emptyM "ariel" 123) "hernan" 234) "jose" 345) "alfredo" 456

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--3)

--O(¿3n?)
ocurrencias :: String -> Map Char Int
ocurrencias [] = emptyM
ocurrencias (c:cs) = contarCaracter c (ocurrencias cs)

-- f aux: --

--O(2n)
-- Hace dos recorridos: Uno para saber si anteriormente existía el caracter buscado dentro del map
-- y otro para insertar o actualizar la cantidad de veces que ese caracter aparecio.
contarCaracter :: Char -> Map Char Int -> Map Char Int
contarCaracter c map =	let cant = lookupM map c
						in	if isNothing cant
							then assocM map c 1
							else assocM map c (fromJust cant + 1)
