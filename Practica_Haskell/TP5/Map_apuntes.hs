--Map
-----

emptyM :: Map k v -- k y v son dos tipos, donde k es la key y v es el valor.
assocM :: Eq k => Map k v -> k -> v -> Map k v
lookUpM :: Eq k => Map k v -> k -> Maybe v
deleteM :: Eq k => Map k v -> k -> Map k v -- Sin la clave y el valor
domM :: Map k v -> Set k


pedirTel :: [String] -> Map String Int -> [Maybe Int]


--	nombre | telefono
-- ------------------
--	"Pablo"| 1234
--	"María"| 603


pedirTel [] map = []
pedirTel (n:ns) map = (lookUp map n) : (pedirTel ns map)




ocur :: [Char] -> Map Char Int
ocur [] = emptyM
ocur (c:cs) = 	let rec = ocur cs	--assocM (ocur cs) c (incrementarV c (ocur cs))
				in				
					assocM rec c (incrementarV c rec)


incrementarV :: Char -> Map Char Int -> Int
incrementarV c map =	let rec = lookUpM c map --
						in  if isNothing (lookUpM c map)
							then 1
							else 1 + (fromJust (lookUpM c map))
