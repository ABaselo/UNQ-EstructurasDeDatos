--1 - CONCEPTOS BASICOS
----------------------------

--1)
--  a)
-- Prop
suc :: Int -> Int
suc x = x + 1


--  b)
-- Proposito: Dados dos numeros enteros, retorna la suma de ellos.
-- Precondicion: 

sumar :: Int -> Int -> Int
sumar x y = x + y

--  c)

maximo :: Int -> Int -> Int

maximo x y =    if x < y 
                    then y
                    else x
--2)

--  a)
--Proposito: Dado un booleano, si es True devuelve False, si es False devuelve True
negar :: Bool -> Bool

negar True = False
negar False = True

--  b)
--Proposito: Dados dos booleanos si ambos son True devuelve True, sino devuelve False.

andLogico :: Bool -> Bool -> Bool

andLogico True True = True
andLogico _ _ = False -- Guion bajo porque no voy a usar los parametros dados. Pueden ser tambien X e Y

--  c)
--Proposito: Dados dos booleanos si alguno de ellos es True devuelve True, sino devuelve False.

orLogico :: Bool -> Bool -> Bool

orLogico False False = False
orLogico _ _ = True

--  d)

--Proposito: Dado un par, retorna solo el primer elemento
primera :: (Int,Int) -> Int

primera (pri,_) = pri

--  e)
--Proposito: Dado un par de numeros devuelve la segunda componente.
segunda :: (Int,Int) -> Int

segunda (_,seg)= seg

--  f)
--Proposito: Dado un par de numeros devuelve la suma de estos
sumaPar :: (Int,Int) -> Int

sumaPar (x,y) = sumar x y

--  g)
--Proposito: Dado un par de numeros devuelve el mayor de estos.
maxDelPar :: (Int,Int) -> Int

maxDelPar (x,y) = maximo x y


--3)

--  a)
--Proposito: Dado un elemento de algun tipo devuelve ese mismo elemento
loMismo :: a -> a

loMismo a = a

--  b)
--Proposito: Dado un elemento de algun tipo devuelve el numero 7.
siempreSiete :: a -> Int

siempreSiete a = 7

--  c)
--Proposito: Dado un elemento de algun tipo devuelve un par con ese elemento en ambas componentes
duplicar :: a -> (a,a)

duplicar a = (a,a)

--  d)
--Proposito: Dado un elemento de algun tipo devuelve una lista con este unico elemento
singleton :: a -> [a]

singleton a = [a]

--4)

--  a)
--Proposito: Dada una lista de elementos, si es vacia devuelve True, sino devuelve False.
isEmpty ::[a] -> Bool

isEmpty [] = True
isEmpty xs = False

--  b)
--Proposito:Dada una lista devuelve su primer elemento
--Precondicion: No es una lista vacia.
head' :: [a] -> a

head' (x:xs) = x

-- c) 
--Proposito: Dada una lista devuelve esa lista menos el primer elemento
tail' :: [a] -> [a]

tail' (x:xs) = xs

--2 - RECURSION

--2.1 - RECURSION SOBRE LISTAS
--  a)
--Proposito: Dada una lista de enteros devuelve la suma de todos sus elementos.
sumatoria :: [Int] -> Int

sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

--  b)
--Proposito: Dada una lista de enteros de algun tipo devuelve el alrgo de esa lista, ed decir, la cantidad de elementos que posee
longitud :: [a] -> Int

longitud [] = 0
longitud (x:xs) = 1 + longitud xs

--  c)
--Proposito: Dada una lista de enteros, devuelve un numero que es el promedio entre todos los elementos de la lista.
--Precondicion: La lista no debe estar vacia.
promedio :: [Int] -> Int

promedio xs = ( sumatoria xs ) `div` ( longitud xs )

--  d)
--Proposito: Dada una lista de enteros, devuenlve la lista de los sucesores de cada elemento
mapSucesor :: [Int] -> [Int]

mapSucesor [] = []
mapSucesor (x:xs) = (x+1):mapSucesor xs

--  e)
--Proposito: Dada una lista de pares de enteros, devuelve una nueva lista en la que cada elemento es la suma de los elementos de cada par.
mapSumaPar :: [(Int,Int)] -> [Int]

mapSumaPar [] = []
mapSumaPar (x:xs) = (sumaPar x) : mapSumaPar xs

--  f)
--Proposito: Dada una lista de pares, devuelve una nueva lista en la que cada elemento es el mayor de las componentes de cada par.
mapMaxDelPar :: [(Int,Int)] -> [Int]

mapMaxDelPar [] = []
mapMaxDelPar (x:xs) = (maxDelPar x):mapMaxDelPar xs

--  g)
--Proposito: Dada una lista de booleanos devuelve True si todos sus elementos son True
todoVerdad :: [Bool] -> Bool

todoVerdad [] = True
todoVerdad (x:xs) = x && todoVerdad xs

--  h)
--Proposito: Dada una lista de booleanos devuelve True si alguno de sus elementos es True
algunaVerdad :: [Bool] -> Bool

algunaVerdad [] = False
algunaVerdad (x:xs) = x || algunaVerdad xs

--  i)
--Proposito: Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual a e.
pertenece :: Eq a => a -> [a] -> Bool

pertenece e [] = False
pertenece e (x:xs) = (e == x) || (pertenece e xs)

--	j)
--Proposito: Dados un elemento e y una lista xs cuenta la cantidad de apariciones de e en xs.
apariciones :: Eq a => a -> [a] -> Int

apariciones e [] = 0
apariciones e (x:xs) =	if (e == x) then
							1 + apariciones e xs
						else
							apariciones e xs

--	k)
--Proposito: Dados un número n y una lista xs, devuelve todos los elementos de xs que son menores a n.
filtrarMenoresA :: Int -> [Int] -> [Int]

filtrarMenoresA n [] = []
filtrarMenoresA n (x:xs) =	if x < n then
								x:filtrarMenoresA n xs
							else
								filtrarMenoresA n xs

--	l)
--Propósito: Dados un elemento y una lista filtrá (eliminá) todas las ocurrencias de ese elemento en la lista.
filtrarElemento :: Eq a => a -> [a] -> [a]

filtrarElemento e [] = []
filtrarElemento e (x:xs) =	if x == e then
								filtrarElemento e xs
							else
								x:filtrarElemento e xs

--	m)
--Propósito: Dada una lista de listas, devuelve la lista de sus longitudes.
mapLongitudes :: [[a]] -> [Int]

mapLongitudes [] = []
mapLongitudes (x:xs) = (longitud x):mapLongitudes xs

--	n)
--Propósito: Dados un número n y una lista de listas, devuelve la lista de aquellas listas que tienen más de n elementos.
longitudMayorA :: Int -> [[a]] -> [[a]]

longitudMayorA n [] = []
longitudMayorA n (x:xs) =	if (longitud x) > n then
								x:longitudMayorA n xs
							else
								longitudMayorA n xs
								
--	ñ)
--Propósito: Dado un elemento e y una lista xs, ubica a e entre medio de todos los elementos de xs.
intercalar :: a -> [a] -> [a]

intercalar e [] = []
intercalar e [x] = x:intercalar e []
intercalar e (x:xs) =	--if (longitud xs) /= 0 then
							x:e:intercalar e xs
						--else
						--x:intercalar e xs
						
						
--	t)
--Propósito: Dadas dos listas de enteros de igual longitud, devuelve una lista de pares (min, max), donde min y max son el mínimo y el máximo entre los elementos de ambas listas en la misma posición.
zipSort :: [Int] -> [Int] -> [(Int,Int)]

zipSort [] [] = []
zipSort (x:xs) (y:ys) =	if x > y then
							(y,x):zipSort xs ys
						else
							(x,y):zipSort xs ys

--2.2 RECURSION SOBRE NUMEROS

--	a)
--Propósito: Dado un número n se devuelve la multiplicación de este número y todos sus anteriores hasta llegar a 0. Si n es 0 devuelve 1. La función es parcial si n es negativo.
factorial :: Int -> Int

factorial 0 = 1
factorial n = n * factorial (n-1)

--	b)
--Propósito: Dado un número n devuelve una lista cuyos elementos sean los números comprendidos entre n y 1 (incluidos). Si el número es inferior a 1, devuelve la lista vacía.
cuentaRegresiva :: Int -> [Int]

cuentaRegresiva 0 = []
cuentaRegresiva n = n:cuentaRegresiva (n - 1)

--	c)
--Propósito: Dado un número n devuelve una lista cuyos elementos sean los números entre 1 y n (incluidos).
contarHasta :: Int -> [Int]

contarHasta 1 = [1]
contarHasta n = (contarHasta (n - 1))++[n]

--	d)
--Propósito: Dado un número n y un elemento e devuelve una lista en la que el elemento e repite n veces.
--Precondición: n es un número positivo mayor a 0.
replicarN :: Int -> a -> [a]

replicarN 0 e = []
replicarN n e = e:replicarN (n - 1) e

--	e)
--Propósito: Dados dos números n y m devuelve una lista cuyos elementos sean los números entre n y m (incluidos).
--Precondición: n < m
desdeHasta :: Int -> Int -> [Int]

--(i)NO ESTOY USANDO P.M. CONSULTAR!(i)
desdeHasta n m = 	if n /= m then 
						n:desdeHasta (n + 1) m
					else
						[m]
						
--	d)
--Propósito: Dados un número n y una lista xs, devuelve una lista con los primeros n elementos de xs. Si xs posee menos de n elementos, se devuelve la lista completa.
takeN :: Int -> [a] -> [a]

takeN 0 xs = []
takeN n [] = []
takeN n (x:xs) = x:takeN (n - 1) xs

--	e)
--Propósito: Dados un número n y una lista xs, devuelve una lista sin los primeros n elementos de lista recibida. Si la lista posee menos de n elementos, se devuelve una lista vacía.
dropN :: Int -> [a] -> [a]

dropN n [] = []
dropN 0 xs = xs
dropN n (x:xs) = drop (n - 1) xs
 
--	f)
--Propósito: Dados un número n y una lista xs, devuelve un par donde la primera componente es la lista que resulta de aplicar takeN a xs, y la segunda componente el resultado de aplicar dropN a xs.
splitN :: Int -> [a] -> ([a],[a])

splitN n xs = ((takeN n xs),(drop n xs))

-- ANEXO CON EJERCICIOS ADICIONALES

--	a)
--Propósito: Dada una lista xs de enteros devuelva una tupla de listas, donde la primera componente contiene todos aquellos números positivos de xs y la segunda todos aquellos números negativos de xs.
particionPorSigno :: [Int] -> ([Int],[Int])

particionPorSigno ns = (listaDePositivos ns,listaDeNegativos ns)


listaDePositivos :: [Int] -> [Int]

listaDePositivos [] = []
listaDePositivos (n:ns) = if n > 0 then
							n:listaDePositivos ns
						else
							listaDePositivos ns


listaDeNegativos :: [Int] -> [Int]
							
listaDeNegativos [] = []
listaDeNegativos (n:ns) = if n < 0 then
							n:listaDeNegativos ns
						else
							listaDeNegativos ns


-- b)
--Propósito: Dada una lista xs de enteros devuelve una tupla de listas, donde la primera componente contiene todos aquellos números pares de xs y la segunda todos aquellos números impares de xs.
particionPorParidad :: [Int] -> ([Int],[Int])

particionPorParidad ns = (listaDePares ns,listaDeImpares ns)


listaDePares :: [Int] -> [Int]

listaDePares [] = []
listaDePares (n:ns) = if even n then
							n:listaDePares ns
						else
							listaDePares ns


listaDeImpares :: [Int] -> [Int]
							
listaDeImpares [] = []
listaDeImpares (n:ns) = if not (even n) then
							n:listaDeImpares ns
						else
							listaDeImpares ns


-- c)
--Propósito: Dada una lista devuelve cada sublista resultante de aplicar tail en cada paso. Ejemplo: subtails "abs" == ["abc","bc","c",""]
subtails :: [a] -> [[a]]

subtails [] = [[]]
subtails xs = xs : subtails (tail xs)

--	d)
--Propósito: Dada una lista xs devuelve una lista de listas donde cada sublista contiene elementos contiguos iguales de xs. Ejemplo: agrupar "AABCCC" = ["AA","B","CC"]
--Precondición: La lista tiene al menos un elemento.
agrupar :: Eq a => [a] -> [[a]]

agrupar [] = []
agrupar (x:xs) = (listaDeElementosIgualesA x (x:xs)) : agrupar (listaDeElementosDistintosA x (x:xs))


--Precondición: La lista no debe estar vacía.
listaDeElementosIgualesA :: Eq a => a -> [a] -> [a]

listaDeElementosIgualesA e [] = []
listaDeElementosIgualesA e (x:xs) =	if x == e then
										x:(listaDeElementosIgualesA e xs)
									else
										listaDeElementosIgualesA e xs


--Precondición: La lista no debe estar vacía.
listaDeElementosDistintosA :: Eq a => a -> [a] -> [a]

listaDeElementosDistintosA e [] = []
listaDeElementosDistintosA e (x:xs) =	if x /= e then
										x:listaDeElementosDistintosA e xs
									else
										listaDeElementosDistintosA e xs


--	e)	
--Propósito: Devuelve True si la primera lista es prefijo de la segunda.
esPrefijo :: Eq a => [a] -> [a] -> Bool

esPrefijo [] ys = True
esPrefijo xs [] = False
esPrefijo (x:xs) (y:ys) =	if x == y then
								esPrefijo xs ys
							else
								False
								
								
--	f)
--Propósito: Devuelve True si la primera lista es sufijo de la segunda.
esSufijo :: Eq a => [a] -> [a] -> Bool

esSufijo xs ys =	if esPrefijo xs (ultimosNElementosDeLaLista (length xs) ys) then
						True
					else
						False 


--Propósito: Dada una lista de elementos una longitud n devuelvo los últimos n elementos de la lista.
ultimosNElementosDeLaLista :: Int -> [a] -> [a]

ultimosNElementosDeLaLista _ [] = []
ultimosNElementosDeLaLista n xs =	if n < (length xs) then
										ultimosNElementosDeLaLista n (tail xs)
									else
										xs

