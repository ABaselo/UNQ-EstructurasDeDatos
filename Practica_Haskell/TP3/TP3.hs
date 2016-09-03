-- 1 - ARBOLES BINARIOS
------------------------
ejemploConInt :: Tree Int
ejemploConInt = NodeT 1 (NodeT 2 (Empty) (NodeT 3 (NodeT 4 (Empty) (Empty)) (Empty))) (NodeT 1 (Empty) (Empty))

ejemploConDir :: Tree Dir
ejemploConDir = NodeT Norte (NodeT Este (Empty) (NodeT Sur (NodeT Oeste (Empty) (Empty)) (Empty))) (NodeT Norte (Empty) (Empty))

ejemploConString :: Tree String
ejemploConString = NodeT "n" (NodeT "ee" (Empty) (NodeT "sss" (NodeT "oooo" (Empty) (Empty)) (Empty))) (NodeT "n" (Empty) (Empty))

ejemploConPersonas :: Tree Persona
ejemploConPersonas = NodeT p1 (NodeT p2 (Empty) (NodeT p3 (NodeT p4 (Empty) (Empty)) (Empty))) (NodeT p1 (Empty) (Empty))

p1 :: Persona
p2 :: Persona
p3 :: Persona
p4 :: Persona

p1 = MKPersona "nombre1" 1
p2 = MKPersona "nombre2" 2
p3 = MKPersona "nombre3" 3
p4 = MKPersona "nombre4" 4

data Tree a = NodeT a (Tree a) (Tree a) | Empty

--1)
--Proposito: Dado un ́arbol binario de enteros devuelve la suma entre sus elementos.
sumarT :: Tree Int -> Int

sumarT (Empty) = 0
sumarT (NodeT n a1 a2) = n + sumarT a1 + sumarT a2


--2)
--Proposito: Dado un  ́arbol binario devuelve su cantidad de elementos, es decir, el tama ̃no del  ́arbol (size en ingles).
sizeT :: Tree a -> Int

sizeT Empty = 0
sizeT (NodeT x a1 a2) = 1 + sizeT a1 + sizeT a2


--3)
--Proposito: Dado un  ́arbol de enteros devuelve un  ́arbol con el doble de cada n ́umero.
mapDobleT :: Tree Int -> Tree Int

mapDobleT Empty = Empty
mapDobleT (NodeT n a1 a2) = NodeT (n*2) (mapDobleT a1) (mapDobleT a2)


--4)
--Proposito: Dado un  ́arbol de direcciones t devuelve un  ́arbol con la direcci ́on opuesta para cada elemento de t.
--Nota: Utilizar el tipo Dir ya definido.
data Dir = Norte | Este | Sur | Oeste

opuesto :: Dir -> Dir

opuesto Norte = Sur
opuesto Este = Oeste
opuesto Sur = Norte
opuesto Oeste = Este

instance Eq Dir where
	Norte == Norte = True
	Este == Este = True
	Sur == Sur = True
	Oeste == Oeste = True
	_ == _ = False

mapOpuestoT :: Tree Dir -> Tree Dir

mapOpuestoT Empty = Empty
mapOpuestoT (NodeT d a1 a2) = NodeT (opuesto d) (mapOpuestoT a1) (mapOpuestoT a2) 


--5)
--Proposito: Dado un  ́arbol de palabras devuelve un  ́arbol con la longitud de cada palabra.
mapLongitudT :: Tree String -> Tree Int

mapLongitudT Empty = Empty
mapLongitudT (NodeT s a1 a2) = NodeT (len s) (mapLongitudT a1) (mapLongitudT a2)  

len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs


--6)
--Proposito: Dados un elemento y un arbol binario devuelve True si existe un elemento igual a ese en el ́arbol.
perteneceT :: Eq a => a -> Tree a -> Bool

perteneceT x Empty = False
perteneceT x1  (NodeT x a1 a2) = x == x1 || perteneceT x1 a1 || perteneceT x1 a2


--7)
--Proposito: Dados un elemento e y un  ́arbol binario devuelve la cantidad de elementos del  ́arbol que son iguales a e.
aparicionesT :: Eq a => a -> Tree a -> Int

aparicionesT x Empty = 0
aparicionesT x (NodeT x1 a1 a2) = 	if x == x1 then
										1 + aparicionesT x a1 + aparicionesT x a2
									else
										aparicionesT x a1 + aparicionesT x a2


--8)
--Proposito: Dado un  ́arbol de personas devuelve el promedio entre las edades de todas las personas.
--Definir las subtareas que sean necesarias para resolver esta funcion.
--Nota: Utilizar el tipo Persona ya definido.
type Edad = Int
type Nombre = String
data Persona = MKPersona Nombre Edad

instance Eq Persona where
	p1 == p2 = (edad p1) == (edad p2) && (nombre p1) == (nombre p2)
	p1 /= p2 = not (p1 == p2)

instance Ord Persona where
	p1 > p2 = (edad p1) > (edad p2)
	p1 < p2 = (edad p1) < (edad p2)
	p1 >= p2 = (edad p1) >= (edad p2)
	p1 <= p2 = (edad p1) <= (edad p2)
	
nombre :: Persona -> Nombre
nombre (MKPersona n _) = n


edad :: Persona -> Edad
edad (MKPersona _ e) = e

promedioEdadesT :: Tree Persona -> Int

promedioEdadesT a = div (sumarEdadesT a) (sizeT a) 

sumarEdadesT :: Tree Persona -> Int

sumarEdadesT Empty = 0
sumarEdadesT (NodeT p a1 a2) = edad p + sumarEdadesT a1 + sumarEdadesT a2


--9)
--Proposito: Dados dos ́arboles construye un arbol t en el que ambos arboles son hijos de t, y en la raız de t se guarda la suma de todos los elementos de los hijos de t.
engancharYSumaEnRaiz :: Tree Int -> Tree Int -> Tree Int

engancharYSumaEnRaiz a1 a2 = NodeT (sumarT a1 + sumarT a2) a1 a2


--10)
--Proposito: Dado un  ́arbol devuelve su cantidad de hojas.
--Nota: una hoja (leaf en ingles) es un nodo que no tiene hijos.
leaves :: Tree a -> Int

leaves Empty = 0
leaves (NodeT x Empty Empty) = 1
leaves (NodeT x a1 a2) = leaves a1 + leaves a2


--11)
--Proposito: Dado un  ́arbol devuelve su altura.
--Nota: la altura (height en ingl ́es) de un  ́arbol es la cantidad m ́axima de nodos entre la ra ́ız y alguna de sus hojas. La altura de un  ́arbol vac ́ıo es cero y la de una hoja es 1.
heightT :: Tree a -> Int

heightT (NodeT _ a1 a2)= if profundidad 0 a1 > profundidad 0 a2 then
							profundidad 0 a1
						else
							profundidad 0 a2
							
profundidad :: Int -> Tree a -> Int 

profundidad n Empty = n
profundidad n (NodeT _ a1 a2) = if (profundidad (n+1) a1) > (profundidad (n+1) a2) then
									(profundidad (n+1) a1)
								else
									(profundidad (n+1) a2)
									
--height :: Tree a -> Int
--height Empty = 0
--height (Node x t1 t2) = 1 + (max (height t1) (height t2))
												
--nodos :: Tree a -> Int 
--nodos Empty = 0
--nodos (NodeT x Empty Empty) = 0
--nodos (NodeT x t1 t2) = 1 + (nodos t1) + (nodos t2)
--nodos t = (size t) - (leaves t)

--espejoT :: Tree a -> Tree a
--espejoT Empty = Empty
--espejoT (NodeT x t1 t2) = NodeT x (espejoT t2) (espejoT t1)

--listInOrder :: Tree a -> [a]
--listInOrder Empty = 
--listInOrder (NodeT x t1 t2) = (listInOrder t1) ++ [x] ++ (listInOrder t2)


--HACER 18, 19, y 20 PARA EL LUNES ANTES DE LA CLASE DE E.D.
