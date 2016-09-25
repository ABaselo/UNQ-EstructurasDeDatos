--Prop.: Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen al conjunto.
--Prec.: Ninguna.
losQuePertenecen :: Eq a => [a] -> Conjunto a -> [a]
losQuePertenecen [] c = []
losQuePertenecen (x:xs) c =	if perteneceC x c 
							then x : losQuePertenecen xs
							else losQuePertenecen xs
							
--(i)
--Prop.: Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
--Prec.: El tipo de las listas debe ser comparable por igual.
sinRepetidos :: [a] -> [a]
sinRepetidos xs = listaC (list2set xs)

list2set :: [a] -> Conjunto a
list2set [] = vacioC
list2set (x:xs) = agregarC x (list2set xs)


data Arbol a = EmptyT | NodeT a (Arbol a) (Arbol a)

--Prop.: Dado un arbol de conjuntos devuelve un conjunto con la union de todos los conjuntos del arbol.
--Prec.: Ninguna.
unirTodos :: Arbol (Conjunto a) -> Conjunto a
unirTodos Empty = vacioC	--(i)
unirTodos (NodeT c Empty Empty) = c
--unirTodos (NodeT c EmptyT t2) = unionC c (unirTodos t2)
--unirTodos (NodeT c t1 EmptyT) = unionC c (unirTodos t1)
unirTodos (NodeT c t1 t2) = unionC c (unionC (unirTodos t1) (unirTodos t2))


--Prop.: Dados dos árboles devuelve un conjunto con los elementos que ambos árboles tienen en común.
interseccionArbol :: Eq a => Tree a -> Tree a -> Conjunto a
interseccionArbol t1 t2 = losQuePertenecenDelArbol t1 (tree2set t2)

losQuePertenecenDelArbol :: Arbol a -> Conjunto a -> Conjunto a
losQuePertenecenDelArbol EmptyT c = 
losQuePertenecenDelArbol (NodeT e t1 t2) c = 	if perteneceC e c
												then unionC (losQuePertenecenDelArbol t1 c) (losQuePertenecenDelArbol t2 c)
												else --INCOMPLETO--

tree2set :: Arbol a -> Conjunto a
tree2set EmptyT = vacioC
--tree2set (NodeT e EmptyT EmptyT) = e
--tree2set (NodeT e t1 EmptyT) = agregarC e (tree2set t1)
--tree2set (NodeT e EmptyT t2) = agregarC e (tree2set t2)
tree2set (NodeT e t1 t2) = agregarC e (unionC (tree2set t1) (tree2set t2))





