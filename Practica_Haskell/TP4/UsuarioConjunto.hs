import Conjunto

--Prop.: Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen al conjunto.
--Prec.: Ninguna.
losQuePertenecen :: Eq a => [a] -> Conjunto a -> [a]
losQuePertenecen [] c = []
losQuePertenecen (x:xs) c =	if perteneceC x c 
							then x : losQuePertenecen xs c
							else losQuePertenecen xs c
							
--(i)
--Prop.: Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
--Prec.: El tipo de las listas debe ser comparable por igual.
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos xs = listaC (list2set xs)

list2set :: Eq a => [a] -> Conjunto a
list2set [] = vacioC
list2set (x:xs) = agregarC x (list2set xs)


data Arbol a = EmptyT | NodeT a (Arbol a) (Arbol a)

--Prop.: Dado un arbol de conjuntos devuelve un conjunto con la union de todos los conjuntos del arbol.
--Prec.: Ninguna.
unirTodos :: Eq a => Arbol (Conjunto a) -> Conjunto a
unirTodos EmptyT = vacioC	--(i)
unirTodos (NodeT c EmptyT EmptyT) = c
--unirTodos (NodeT c EmptyT t2) = unionC c (unirTodos t2)
--unirTodos (NodeT c t1 EmptyT) = unionC c (unirTodos t1)
unirTodos (NodeT c t1 t2) = unionC c (unionC (unirTodos t1) (unirTodos t2))


--Prop.: Dados dos árboles devuelve un conjunto con los elementos que ambos árboles tienen en común.
interseccionArbol :: Eq a => Arbol a -> Arbol a -> Conjunto a
interseccionArbol t1 t2 = losQuePertenecenDelArbol t1 (tree2set t2)

--(i) complejo de resolver
--Prop.: Dado un arbol y un conjunto retorno un conjunto cuyos elementos son aquellos que están presentes tanto en el arbol como el conjunto
--		 dado.
--Prec.: Ninguna.
losQuePertenecenDelArbol :: Eq a => Arbol a -> Conjunto a -> Conjunto a
losQuePertenecenDelArbol EmptyT c = vacioC
losQuePertenecenDelArbol (NodeT e t1 t2) c =
									 	if perteneceC e c
										then agregarC e ( unionC (losQuePertenecenDelArbol t1 c) (losQuePertenecenDelArbol t2 c) )
										else unionC (losQuePertenecenDelArbol t1 c) (losQuePertenecenDelArbol t2 c)

--(i) MAL: Puede haber elementos del conjunto que no pertenezcan a al arbol dado. El borrar tmb está mal. No se puede borrar algo que no está en el conjunto.
--Prop.: Dado un arbol y un conjunto retorno un conjunto cuyos elementos son aquellos que están presentes tanto en el arbol como el conjunto
--		 dado.
--Prec.: 
--losQuePertenecenDelArbol :: Arbol a -> Conjunto a -> Conjunto a
--losQuePertenecenDelArbol EmptyT c = c
--losQuePertenecenDelArbol (NodeT e t1 t2) c =
--									 	if perteneceC e c
--										then unionC (losQuePertenecenDelArbol t1 c) (losQuePertenecenDelArbol t2 c)
--										else unionC (losQuePertenecenDelArbol t1 (borrarC e c)) (losQuePertenecenDelArbol t2 (borrarC e c))

tree2set :: Eq a => Arbol a -> Conjunto a
tree2set EmptyT = vacioC
--tree2set (NodeT e EmptyT EmptyT) = e
--tree2set (NodeT e t1 EmptyT) = agregarC e (tree2set t1)
--tree2set (NodeT e EmptyT t2) = agregarC e (tree2set t2)
tree2set (NodeT e t1 t2) = agregarC e (unionC (tree2set t1) (tree2set t2))





--Algunos ejemplos de arboles y conjuntos.

ej1 :: Conjunto Int
ej1 = agregarC 1 (agregarC 2 (agregarC 3 (agregarC 4 (agregarC 5 vacioC))))
ej2 :: Conjunto Int
ej2 = agregarC 5 (agregarC 6 (agregarC 7 (agregarC 8 (agregarC 9 vacioC))))
ej3 :: Conjunto Int
ej3 = agregarC 2 (agregarC 6 (agregarC 10 (agregarC 0 (agregarC 2 vacioC))))

ac1 :: Arbol (Conjunto Int)
ac1 = (NodeT ej1 (NodeT ej2 (NodeT ej3 EmptyT EmptyT) EmptyT) (NodeT ej2 EmptyT (NodeT ej3 EmptyT (NodeT ej2 (NodeT ej3 EmptyT EmptyT) EmptyT))))

a1 :: Arbol Int
a1 = (NodeT 1 (NodeT 2 (NodeT 3 EmptyT EmptyT) EmptyT) (NodeT 4 EmptyT (NodeT 5 EmptyT (NodeT 6 (NodeT 7 EmptyT EmptyT) EmptyT))))

a2 :: Arbol Int
a2 = (NodeT 8 (NodeT 9 (NodeT 10 EmptyT EmptyT) EmptyT) (NodeT 8 EmptyT (NodeT 9 EmptyT (NodeT 10 (NodeT 8 EmptyT EmptyT) EmptyT))))

