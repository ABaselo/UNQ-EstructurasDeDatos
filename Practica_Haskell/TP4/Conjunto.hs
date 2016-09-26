module Conjunto (Conjunto, vacioC, agregarC, perteneceC, cantidadC, borrarC, unionC, listaC) where

--INVARIANTE DE REPRESENTACION:
--- + Dado un elemento 'e' perteneciente al conjunto, no existe otro 'x' perteneciente al conjunto que sea igual a 'e'.
---	  Es decir, no hay elementos repetidos en el conjunto.		

data Conjunto a = MKSet Int [a]

ej1 :: Conjunto Int
ej1 = MKSet 5 [1,2,3,4,5]

ej2 :: Conjunto Int
ej2 = MKSet 9 [1,2,3,4,5,6,7,8,9]

--Prop.: Crea un conjunto vacío.
vacioC :: Eq a => Conjunto a
vacioC = MKSet 0 []


--Prop.: Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
agregarC e (MKSet n xs) = 	if not (perteneceC e (MKSet n xs))
							then MKSet (n+1) (e:xs)
							else MKSet n xs
		
							
--Prop.: Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
perteneceC :: Eq a => a -> Conjunto a -> Bool
perteneceC e (MKSet _ []) = False
perteneceC e (MKSet n (x:xs)) = (e == x) || perteneceC e (MKSet n xs)


--Prop.: Devuelve la cantidad de elementos distintos de un conjunto
cantidadC :: Eq a => Conjunto a -> Int
cantidadC (MKSet n _) = n


--Prop.: Devuelve el conjunto sin el elemento dado.
borrarC :: Eq a => a -> Conjunto a -> Conjunto a
borrarC e conj = borrarElementoEnC e conj

--(i) esta recursión funciona como un filtro: examina una lista y va descartando aquellos que sean igual a 'e'.
borrarElementoEnC :: Eq a => a -> Conjunto a -> Conjunto a
borrarElementoEnC e (MKSet n []) = vacioC--(i)
borrarElementoEnC e (MKSet n (x:xs)) = 	if e == x 
										then borrarElementoEnC e (MKSet (n-1) xs)
										else agregarC x (borrarElementoEnC e (MKSet n xs))--(i)
									

--Prop.: Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unionC (MKSet n xs) conj = agregarListaEnConjunto xs conj
 
agregarListaEnConjunto :: Eq a => [a] -> Conjunto a -> Conjunto a
agregarListaEnConjunto [] conj = conj
agregarListaEnConjunto (x:xs) (MKSet n ys) =	if elem x ys
												then agregarListaEnConjunto xs (MKSet n ys)
												else agregarListaEnConjunto xs (MKSet (n+1) (x:ys))


--Prop.: Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
listaC :: Eq a => Conjunto a -> [a]
listaC (MKSet _ xs) = xs


