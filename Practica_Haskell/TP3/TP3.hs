-- 1 - ARBOLES BINARIOS
------------------------
ejemploConInt :: Tree Int
ejemploConInt = NodeT 1 (NodeT 2 (Empty) (NodeT 3 (NodeT 4 (Empty) (Empty)) (Empty))) (NodeT 1 (Empty) (Empty))

ejemploConDir :: Tree Dir
ejemploConDir = NodeT Norte (NodeT Este (NodeT Oeste Empty Empty) (NodeT Sur (NodeT Oeste (Empty) (Empty)) (Empty))) (NodeT Norte (Empty) (Empty))

ejemploConString :: Tree String
ejemploConString = NodeT "n" (NodeT "ee" (Empty) (NodeT "sss" (NodeT "oooo" (Empty) (Empty)) (Empty))) (NodeT "n" (Empty) (Empty))

ejemploConPersonas :: Tree Persona
ejemploConPersonas = NodeT p1 (NodeT p2 (Empty) (NodeT p3 (NodeT p4 (Empty) (Empty)) (Empty))) (NodeT p1 (Empty) (Empty))

ejemploConLsDeInt :: Tree [Int]
ejemploConLsDeInt = NodeT [1,1,1] (NodeT [3,3,3] (NodeT [4,4,4] Empty Empty) (NodeT [5,5,5] (NodeT [6,6,6] Empty Empty) Empty)) (NodeT [2,2,2] Empty Empty)

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
--Propósito: Dado unárbol binario de enteros devuelve la suma entre sus elementos.
sumarT :: Tree Int -> Int
sumarT (Empty) = 0
sumarT (NodeT n a1 a2) = n + sumarT a1 + sumarT a2


--2)
--Propósito: Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
sizeT :: Tree a -> Int
sizeT Empty = 1
sizeT (NodeT x a1 a2) = 1 + sizeT a1 + sizeT a2


--3)
--Propósito: Dado un árbol de enteros devuelve un árbol con el doble de cada número.
mapDobleT :: Tree Int -> Tree Int
mapDobleT Empty = Empty
mapDobleT (NodeT n a1 a2) = NodeT (n*2) (mapDobleT a1) (mapDobleT a2)


--4)
--Propósito: Dado un árbol de direcciones t devuelve un árbol con la dirección opuesta para cada elemento de t.
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
--Propósito: Dado un árbol de palabras devuelve un árbol con la longitud de cada palabra.
mapLongitudT :: Tree String -> Tree Int
mapLongitudT Empty = Empty
mapLongitudT (NodeT s a1 a2) = NodeT (len s) (mapLongitudT a1) (mapLongitudT a2)  

len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs


--6)
--Propósito: Dados un elemento y un arbol binario devuelve True si existe un elemento igual a ese en el árbol.
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT x Empty = False
perteneceT x1  (NodeT x a1 a2) = x == x1 || perteneceT x1 a1 || perteneceT x1 a2


--7)
--Propósito: Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT x Empty = 0
aparicionesT x (NodeT x1 a1 a2) = 	if x == x1 then
										1 + aparicionesT x a1 + aparicionesT x a2
									else
										aparicionesT x a1 + aparicionesT x a2


--8)
--Propósito: Dado un árbol de personas devuelve el promedio entre las edades de todas las personas.
--Definir las subtareas que sean necesarias para resolver esta función.
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
--Propósito: Dados dos árboles construye un arbol t en el que ambos arboles son hijos de t, y en la raız de t se guarda la suma de todos los elementos de los hijos de t.
engancharYSumaEnRaiz :: Tree Int -> Tree Int -> Tree Int
engancharYSumaEnRaiz a1 a2 = NodeT (sumarT a1 + sumarT a2) a1 a2


--10)
--Propósito: Dado un árbol devuelve su cantidad de hojas.
--Nota: una hoja (leaf en inglés) es un nodo que no tiene hijos.
leaves :: Tree a -> Int
leaves Empty = 0
leaves (NodeT x Empty Empty) = 1
leaves (NodeT x a1 a2) = leaves a1 + leaves a2


--11)	(i)
--Propósito: Dado un árbol devuelve su altura.
--Nota: la altura (height en inglés) de un árbol es la cantidad máxima de nodos entre la raíz y alguna de sus hojas. La altura de un árbol vacío es cero y la de una hoja es 1.
heightT :: Tree a -> Int
heightT Empty = -1
heightT (NodeT _ a1 a2)= 1 + max2 (heightT a1) (heightT a2)

max2 :: Int -> Int -> Int
max2 n1 n2 = if n1 > n2 then
				n1
			else
				n2

--12)
--Propósito: Dado un árbol devuelve el número de nodos que no son hojas.
nodes :: Tree a -> Int
nodes Empty = 0
nodes (NodeT _ Empty Empty) = 0
nodes (NodeT _ a1 a2) = 1 + nodes a1 + nodes a2
--nodos t = (size t) - (leaves t)


--13)
--Propósito: Dado un árbol devuelve el árbol resultante de intercambiar el hijo izquierdo con el derecho, en cada nodo del árbol.
espejoT :: Tree a -> Tree a
espejoT Empty = Empty
espejoT (NodeT x a1 a2) = NodeT x (espejoT a2) (espejoT a1)


--14)
--Propósito: Dado un árbol devuelve una lista que representa el resultado de recorrerlo en modo in-order.
--Nota: En el modo in-order primero se procesan los elementos del hijo izquierdo, luego la raiz y luego los elementos del hijo derecho.
listInOrder :: Tree a -> [a]
listInOrder Empty = []
listInOrder (NodeT x a1 a2) = listInOrder a1 ++ [x] ++ listInOrder a2


--15)
--Propósito: Dado un árbol devuelve una lista que representa el resultado de recorrerlo en modo pre-order.
--Nota: En el modo pre-order primero se procesa la raiz, luego los elementos del hijo izquierdo, a continuación los elementos del hijo derecho.
listPreOrder :: Tree a -> [a]
listPreOrder Empty = []
listPreOrder (NodeT x a1 a2) = [x] ++ listPreOrder a1 ++ listPreOrder a2


--16)
--Propósito: Dado un árbol devuelve una lista que representa el resultado de recorrerlo en modo post-order.
--Nota: En el modo post-order primero se procesan los elementos del hijo izquierdo, a continuación los elementos del hijo derecho y finalmente la raiz.
listPosOrder :: Tree a -> [a]
listPosOrder Empty = []
listPosOrder (NodeT x a1 a2) = listPosOrder a1 ++ listPosOrder a2 ++ [x]


--17)	(i) No es así -----> concatenarListasT a1 ++ [x] ++ concatenarListasT a2
--Propósito: Dado un árbol de listas devuelve la concatenación de todas esas listas. El recorrido debe ser in-order.
concatenarListasT :: Tree [a] -> [a]
concatenarListasT Empty = []
concatenarListasT (NodeT x a1 a2) = concatenarListasT a1 ++ x ++ concatenarListasT a2



--18)
--Propósito: Dados un número n y un árbol devuelve una lista con los nodos de nivel n.
--Nota: El primer nivel de un árbol (su raı́z) es 0.
levelN :: Int -> Tree a -> [a]
levelN 0 (NodeT x a1 a2) = [x]
levelN n Empty = []
levelN n (NodeT x a1 a2) = levelN (n-1) a1 ++ levelN (n-1) a2



--19)
--Propósito: Dado un árbol devuelve una lista de listas en la que cada elemento representa un nivel de dicho árbol.
listPerLevel :: Tree a -> [[a]]
listPerLevel a = recolectarNNiveles (heightT a) a

recolectarNNiveles :: Int -> Tree a -> [[a]]
recolectarNNiveles 0 a = [levelN 0 a]
recolectarNNiveles n a = [levelN n a] ++ recolectarNNiveles (n-1) a



--20)
--Propósito: Dado un árbol devuelve su ancho (width en inglés), que es la cantidad de nodos del nivel con mayor cantidad de nodos.
widthT :: Tree a -> Int
widthT a = maxLen (listPerLevel a)

maxLen :: [[a]] -> Int
maxLen [] = 0
maxLen (x:xs) = max2 (len x) (maxLen xs)


-- 2 - EXPRESIONES ARITMÉTICAS
------------------------------

--EJERCICIO 1

--BinOp por OpBinaria
--UnOp por OpUnaria
--BinExp por ConsExpBinaria
--UnExp por ConsExpUnaria
--Const por Constante

data Exp = 	Const Int
			| UnExp UnOp Exp
			| BinExp BinOp Exp Exp
			
--data UnOp = Neg

data BinOp = Suma | Resta | Mult | Div

--1)
--Propósito: Dada una expresión evalúe esta expresión y retorne su valor.
--Precondición: Es parcial cuando e2 es cero en la Exp = BinExp Div e1 e2

--		- (6+6)-((6-5)/(4*7)) = - 12 - (1 )/28
cuenta :: Exp
cuenta = UnExp Neg (BinExp Resta (BinExp Suma (Const 6) (Const 6)) (BinExp Div (BinExp Resta (Const 6) (Const 5)) (BinExp Mult (Const 4) (Const 7))))

--eval :: Exp -> Int
--eval (Const n) = n
--eval (UnExp Neg e) = - eval e
--eval (BinExp Suma e1 e2) = eval e1 + eval e2
--eval (BinExp Resta e1 e2) = eval e1 - eval e2
--eval (BinExp Mult e1 e2) = eval e1 * eval e2
--eval (BinExp Div e1 e2) = div (eval e1) (eval e2)
			
			
--2)
--Propósito: 

--		- (6+6)-((6-5)/(0*7)) = - 12 - (1 )/28
--cuenta :: Exp
--cuenta = UnExp Neg (BinExp Resta (BinExp Suma (Const 6) (Const 6)) (BinExp Div (BinExp Resta (Const 6) (Const 5)) (BinExp Mult (Const 4) (Const 7))))


--simplificar :: Exp -> Exp
--simplificar (Const n) = Const n
--simplificar (UnExp Neg e) = UnExp Neg (simplificar e)
--simplificar (BinExp bo e1 e2) = sim (BinExp bo (simplificar e1) (simplificar e2))

--sim :: Exp -> Exp
--sim (BinExp Suma (Const 0) e2) = e2
--sim (BinExp Suma e1 (Const 0)) = e1
--sim (BinExp Resta e1 (Const 0)) = e1
--sim (BinExp Resta (Const 0) e2) = UnExp Neg e2
--sim (BinExp Mult e1 (Const 0)) = Const 0
--sim (BinExp Mult (Const 0) e2) = Const 0
--sim (BinExp Mult e1 (Const 1)) = e1
--sim (BinExp Mult (Const 1) e2) = e2
--sim (BinExp Div (Const 0) e2) = Const 0
--sim (BinExp Div e1 (Const 1)) = e1
--sim e = e


--EJERCICIO 2
-------------

data UnOp = Neg | Inc | Dec

--1)

eval :: Exp -> Int
eval (Const n) = n
eval (UnExp Neg e) = - eval e
eval (UnExp Dec e) =  eval e - 1
eval (UnExp Inc e) = 1 + eval e
eval (BinExp Suma e1 e2) = eval e1 + eval e2
eval (BinExp Resta e1 e2) = eval e1 - eval e2
eval (BinExp Mult e1 e2) = eval e1 * eval e2
eval (BinExp Div e1 e2) = div (eval e1) (eval e2)




simplificar :: Exp -> Exp
simplificar (Const n) = Const n
simplificar (UnExp Neg e) = UnExp Neg (simplificar e)
simplificar (UnExp Inc e) = UnExp Inc (simplificar e)
simplificar (UnExp Dec e) = UnExp Dec (simplificar e)
simplificar (BinExp bo e1 e2) = sim (BinExp bo (simplificar e1) (simplificar e2))

sim :: Exp -> Exp
sim (BinExp Suma (Const 0) e2) = e2
sim (BinExp Suma e1 (Const 0)) = e1
sim (BinExp Resta e1 (Const 0)) = e1
sim (BinExp Resta (Const 0) e2) = UnExp Neg e2

sim (BinExp Suma (Const 1) e2) = Inc e2
sim (BinExp Suma e1 (Const 1)) = Inc e1
sim (BinExp Resta e1 (Const 1)) = Dec e1
sim (BinExp Resta (Const 1) e2) = UnExp Neg (Dec e2)

sim (BinExp Mult e1 (Const 0)) = Const 0
sim (BinExp Mult (Const 0) e2) = Const 0
sim (BinExp Mult e1 (Const 1)) = e1
sim (BinExp Mult (Const 1) e2) = e2
sim (BinExp Div (Const 0) e2) = Const 0
sim (BinExp Div e1 (Const 1)) = e1
sim e = e

