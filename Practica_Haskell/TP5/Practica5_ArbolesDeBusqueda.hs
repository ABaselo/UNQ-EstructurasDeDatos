--INVARIANTE:
--	Dado un NodeT x t1 t2
--		1- Los elementos de t1 son menores que x.
--		2- Los elementos de t2 son mayores que x.
--		3- t1 y t2 son BST.

--Prop.: Dado un BST inserta un elemento en el árbol.
--Prec.: El elem dado no pertenece al BST.
insertBST :: Ord a => a -> Tree a -> Tree a
insertBST e EmptyT = NodeT e EmptyT EmptyT
insertBST e (NodeT x t1 t2) = 	if e==x
								then NodeT e t1 t2
								else 	if e<x
										then NodeT x (insertBST e t1) t2
										else NodeT x t1 (insertBST e t2)

--Prop.: Dado un BST dice si el elemento pertenece o no al árbol.
perteneceBST :: Ord a => a -> Tree a -> Bool
perteneceBST e EmptyT = False
perteneceBST e (NodeT x t1 t2) = 	if e <= x
									then e==x || perteneceBST e t1
									else perteneceBST e t2

--Prop.: Dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
--splitMinBST :: Ord a => Tree a -> (a, Tree a)
--splitMinBST t@(NodeT e t1 t2) = f t EmptyT

--f :: Tree a -> Int -> (a, Tree a)
--f (Node )


esHoja :: Tree a -> Bool
esHoja (NodeT _ EmptyT EmptyT) = True
esHoja t1 = False

elem :: Tree a -> a
elem (NodeT e _ _) = e

--Prop.: Dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
--splitMaxBST :: Ord a => Tree a -> (a, Tree a)

--Prop.: Dado un BST y un elemento, devuelve el máximo elemento que sea menor al elemento dado.
--Prec.: Error en caso de no encontrar el elemento buscado.
elMaximoMenorA :: Ord a => a -> Tree a -> a
elMaximoMenorA x EmptyT = error "No existe el elemento buscado."
elMaximoMenorA x (NodeT e t1 t2) = 	if e < x
									then buscarMaximaCotaSuperiorEnT t2 e x
									else	if e > x
											then elMaximoMenorA x t1
											else maxBST t1

--Prop.: Dados una cota inferior, una cota superior y un arbol se devuelve el máximo elemento del arbol que sea menor a la cota superior.
--Prec.: Ninguna.
buscarMaximaCotaSuperiorEnT :: Ord a => Tree a -> a -> a -> a
buscarMaximaCotaSuperiorEnT EmptyT inf sup  = inf
buscarMaximaCotaSuperiorEnT (NodeT e t1 t2) inf sup = 
			if inf < e
			then	if e < sup
					then buscarMaximaCotaSuperiorEnT t2 e sup
					else buscarMaximaCotaSuperiorEnT t1 inf sup
			else buscarMaximaCotaSuperiorEnT t2 inf sup

elementoDelNodoRaiz :: Tree a -> a
elementoDelNodoRaiz (NodeT e _ _) = e

maxBST :: Tree a -> a
maxBST (NodeT e EmptyT EmptyT) = e
maxBST (NodeT e _ t) = maxBST t

minBST :: Tree a -> a
minBST (NodeT e EmptyT EmptyT) = e
minBST (NodeT e t _) = minBST t
				
--Prop.: Dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al elemento dado.
--elMinimoMayorA :: Ord a => a -> Tree a -> [a]


data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

ejBST :: Tree Int
ejBST = NodeT 9 (NodeT 4 (NodeT 2 (NodeT 1 EmptyT EmptyT) (NodeT 3 EmptyT EmptyT)) (NodeT 5 EmptyT EmptyT)) (NodeT 15 (NodeT 12 EmptyT EmptyT) (NodeT 22 EmptyT EmptyT))

