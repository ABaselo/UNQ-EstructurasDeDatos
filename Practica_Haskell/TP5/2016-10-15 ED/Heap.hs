module Heap() where


{-
INTERFACE DE HEAP

emptyH :: Heap a

isEmptyH :: Heap a -> Bool

insertH :: Ord a => a -> Heap a -> Heap a

findMin :: Ord a => Heap a -> a -- Parcial en emptyH

deleteMin :: Ord a => Heap a -> Heap a -- Parcial en emptyH

splitMin :: Ord a => Heap a -> (a,Heap a) -- Parcial en emptyH

-}

-- ESTRUCTURA DE REPRESENTACIÓN
-- (Implementación de un min-heap)

type HeapTree a = Tree a
-- INVARIANTES DE REPRESENTACIÓN:
--	* El nodo en la raíz es el menor de todo el árbol
--	* Ambos subarboles son Heap

data Dir = Izq | Der

type Dirs = [Dir]

data Heap a = H Dirs (HeapTree a) 
-- INVARIANTES DE REPRESENTACIÓN:
--	* El árbol es completo
--	* En Dirs se encuentra la próxima posición donde se debe insertar un elemento
--	  para que el árbol siga siendo completo. La lista se lee al reverso.

-- O(1)
-- PROPÓSITO: Retorna un heap vacío.
emptyH :: Heap a
emptyH = H [] EmptyT

-- O(1)
-- PROPÓSITO: Dado un heap, indica si éste es vacío.
isEmptyH :: Heap a -> Bool
isEmptyH (H np t) = isEmptyT t

-- PROPÓSITO: Dado un elemento y un heap, retorna un heap que contiene al elemento insertado.
-- log(n)
insertH :: Ord a => a -> Heap a -> Heap a
insertH e (H np t) = H (nextPos np) (insertT e (reverse np) t)

-- PROPÓSITO: Dado un elemento, un Dirs y un árbol, retorna un árbol (que respeta los invariantes de heap) 
-- que contiene el elemento a insertar.
-- log(n)
insertT :: Ord a => a -> Dirs -> Tree a -> Tree a
insertT e [] EmptyT = NodeT e EmptyT EmptyT 
insertT e (Izq:np) (NodeT x t1 t2) = orderUpIzq x (insertT e np t1) t2
insertT e (Der:np) (NodeT x t1 t2) = orderUpDer x t1 (insertT e np t2)

-- PRECONDICIÓN: Los árboles son heap.
-- PROPÓSITO: Dado una raíz y dos subarboles, arma un árbol con invariantes heap
-- reordenando los elementos del subarbol izquierdo y la raíz.
-- O(1)
orderUpIzq :: Ord a => a -> Tree a -> Tree a -> Tree a
orderUpIzq m tree1@(NodeT m' t1 t2) tree2 =		if m < m'
							then NodeT m tree1 tree2
							else NodeT m' (NodeT m t1 t2) tree2 
												
-- PRECONDICIÓN: Los árboles son heap.
-- PROPÓSITO: Dado una raíz y dos subarboles, arma un árbol con invariantes heap
-- reordenando los elementos del subarbol derecho y la raíz.
-- O(1)
orderUpDer :: Ord a => a -> Tree a -> Tree a -> Tree a
orderUpDer m tree1 tree2@(NodeT m' t1 t2) =		if m < m'
							then NodeT m tree1 tree2
							else NodeT m' tree1 (NodeT m t1 t2)
												
-- PROPÓSITO: Dado un heap, retorna el mismo heap sin el mínimo.							
-- PRECONDICIÓN: El heap debe tener al menos un elemento.
-- log(n)
deleteMin :: Ord a => Heap a -> Heap a -- Parcial en emptyH
deleteMin (H np t) = H (prevPos np) (deleteT (reverse(prevPos np)) t)

-- Dado un Dirs y un heap, retorna al heap sin su elemento mínimo.
-- PRECONDICIÓN: El heap debe tener al menos un elemento.
-- log(n)
deleteT :: Ord a => Dirs -> Tree a -> Tree a
deleteT  lp t =	case (splitLast lp t)	of
				(m', EmptyT) -> EmptyT
				(m', NodeT m ti' td') -> orderDown m' ti' td'

-- PRECONDICIÓN: Los subarboles son Heaps. Si el subárbol izquierdo es vacío, el derecho también (digamos que cumplen 
-- los invariantes de los subarboles de un heap).
-- PROPÓSITO: Dado un elemento raíz y dos subarboles, ordena los elementos retornando un
-- árbol que es Heap. Baja el elemento raíz hasta donde deba estar.
orderDown :: Ord a => a -> Tree a -> Tree a -> Tree a
orderDown m EmptyT EmptyT = NodeT m EmptyT EmptyT

orderDown m (ti@(NodeT mi tii tid)) EmptyT =	if m <= mi 
												then NodeT m ti EmptyT
												else NodeT mi (orderDown m tii tid) EmptyT

orderDown m (ti@(NodeT mi tii tid)) 
			(td@(NodeT md tdi tdd)) =	if m <= mi && m <= md 
										then NodeT m ti td
										else 	if mi <= md  -- m es mayor que el mas chico de mi y md
												then NodeT mi (orderDown m tii tid) td
												else NodeT md ti (orderDown m tdi tdd)

-- PROPÓSITO: Dado un Dirs y un Heap, retorna una tupla con el elemento que se encuentra en la última posición que se insertó
-- y el heap sin ese elemento.
-- log(n)
splitLast :: Dirs -> Tree a -> (a, Tree a)

splitLast []  (NodeT m EmptyT EmptyT) = (m, EmptyT)

splitLast (Izq:oc) (NodeT m ti td) =	let (m', ti') = splitLast oc ti
										in (m', NodeT m ti' td)

splitLast (Der :oc) (NodeT m ti td) = 	let (m', td') = splitLast oc td
										in (m', NodeT m ti td')

-- Dado un Dirs, retorna un Dirs que representa la próxima posición en un heap.
-- O(n)
nextPos :: Dirs -> Dirs
nextPos [] = [Izq]
nextPos (Izq:np) = Der : np
nextPos (Der:np) = Izq: (nextPos np)

-- PROPÓSITO: Dado un Dirs, retorna un Dirs que representa la anterior posición en un heap.
-- PRECONDICIÓN: El Dirs debe tener al menos un elemento.
-- O(n)
prevPos [Izq]    = []
prevPos (Der :oc) = Izq : oc
prevPos (Izq:oc) = Der : prevPos oc

-- PROPÓSITO: Dado un heap, retorna su elemento mínimo.
-- PRECONDICIÓN: El heap debe tener al menos un elemento.
-- O(1)
findMin :: Ord a => Heap a -> a -- Parcial en emptyH
findMin (H np (NodeT m t1 t2)) = m 

-- PROPÓSITO: Dado un heap, retorna un par que contiene el element mínimo del heap y el heap sin el mínimo.
-- PRECONDICIÓN: El heap debe tener al menos un elemento.
-- log(n)
splitMin :: Ord a => Heap a -> (a,Heap a) -- Parcial en emptyH
splitMin h = ((findMin h), (deleteMin h)) 




-- Definición de Tree

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

isEmptyT :: Tree a -> Bool
isEmptyT EmptyT = True
isEmptyT (NodeT _ _ _) = False
