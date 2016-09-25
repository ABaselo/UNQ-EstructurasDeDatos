esVacio EmptyT = True
esVacio _      = False

ceroORaiz EmptyT          = 0
ceroORaiz (NodeT x t1 t2) = x

engancharYSumarYRaices :: 
		Tree Int -> Tree Int -> Tree Int
engancharYSumarYRaices t1 t2 =
	NodeT (ceroORaiz t1 + ceroORaiz t2)
		t1
		t2

hojas :: Tree a -> [a]
hojas EmptyT = []
-- hojas (NodeT x EmptyT EmptyT) = [x] -- este caso redefine esHoja
hojas t@(NodeT x t1 t2) =
	if esHoja t
	   then x : hojas t1 ++ hojas t2
	   else hojas t1 ++ hojas t2

--	hojas t1 ++ hojas t2

	--if esVacio t1 && esVacio t2  -- no reutiliza esHoja pero podria ser
	--	then  x : hojas t1 ++ hojas t2
	--	else  hojas t1 ++ hojas t2

hojas :: Tree a -> [a]
hojas EmptyT = []
hojas (NodeT x EmptyT EmptyT) = [x]
hojas (NodeT x t1 t2) =
	   hojas t1 ++ hojas t2


heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT x t1 t2) = 
	 1 + max (heightT t1) (heightT t2)

nodes :: Tree a -> [a]
nodes EmptyT = []
nodes t@(NodeT x t1 t2) =
	if not (esHoja t)
	   then x : nodes t1 ++ nodes t2
	   else nodes t1 ++ nodes t2

espejoT :: Tree a -> Tree a
espejoT EmptyT = EmptyT
espejoT (NodeT x t1 t2) =
	NodeT x (espejoT t2) (espejoT t1)

toList :: Tree a -> [a]
toList EmptyT = []
toList (NodeT x t1 t2) =
    [x] ++ (toList t1) ++ (toList t2)
--    (toList t1) ++ [x] ++ (toList t2)
--    (toList t1) ++ (toList t2) ++ [x] 

levelN :: Int -> Tree a -> [a]
levelN _ EmptyT = []
levelN 0 (NodeT x _ _) = [x]
levelN n (NodeT _ t1 t2) =
	levelN (n-1) t1 ++ levelN (n-1) t2

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = []
listPerLevel t = losNiveles t (heightT t - 1)

losNiveles :: Tree a -> Int -> [[a]]
losNiveles t 0 = levelN 0 t : []
losNiveles t n = 
	levelN n t : lostNiveles t (n-1)

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = []
listPerLevel (NodeT x t1 t2) =
	[x] : zipConcat (listPerLevel t1) 
    	            (listPerLevel t2)

zipConcat :: [[a]] -> [[a]] -> [[a]]
zipConcat xs [] = xs
zipConcat [] ys = ys
zipConcat (x:xs) (y:ys) =
	(x ++ y) : zipConcat xs ys

-- Ejemplo de que
-- aunque sea [[a]] termina con []
cadaHeadSublista :: [a] -> [[a]]
cadaHeadSublista []     = []
cadaHeadSublista (x:xs) = 
     [x] : cadaHeadSublista xs

widthT :: Tree a -> Int
widthT EmptyT = 0
widthT t = maximum 
            (mapLongitudes (listPerLevel t))

-- Imposible!!!
-- widthT :: Tree a -> Int 
-- widthT EmptyT =
-- widthT (NodeT x t1 t2) =
--	(widthT t1) (width t2)

izquierdoMenorYDerechoMayor :: Tree Int -> Bool
izquierdoMenorYDerechoMayor EmptyT =
izquierdoMenorYDerechoMayor (Node x t1 t2) =
	todosMenores x t1 && todosMayores x t2

izquierdoMenorYDerechoMayor :: Tree Int -> Bool
izquierdoMenorYDerechoMayor EmptyT = False
izquierdoMenorYDerechoMayor (Node x t1 t2) =
	todosMenores x t1 && todosMayores x t2

todosMenores _ EmptyT          = True
todosMenores n (NodeT x t1 t2) =
	n > x &&
		todosMenores n t1 && todosMenores n t2

todosMayores _ EmptyT          = True
todosMayores n (NodeT x t1 t2) =
	n < x &&
		todosMayores n t1 && todosMayores n t2

caminoIzquierdo :: Tree a -> [a]
caminoIzquierdo EmptyT = [] 
-- caminoIzquierdo (NodeT x EmptyT _) =
--	[x]
caminoIzquierdo (NodeT x t1 _) =
	x : caminoIzquierdo t1

-- Prec.: t no es EmptyT
maxT :: Ord a => Tree a -> a
maxT (NodeT x EmptyT EmptyT) = x
maxT (NodeT x t1 EmptyT) = maxGenerico x 
                                 (maxT t1)
maxT (NodeT x EmptyT t2) = maxGenerico x 
                                 (maxT t2)
maxT (NodeT x t1 t2) = 
    maxGenerico x 
      (maxGenerico (maxT t1) (maxT t2))

-- Prec.: t no es EmptyT
minT :: Ord a => Tree a -> a
minT (NodeT x Empty Empty) = x
minT (NodeT x EmptyT t2) = min x (minT t2)
minT (NodeT x t1 EmptyT) = min x (minT t1)
minT (NodeT x t1 t2) = 
	min x (min (minT t1) (minT t2))


maxGenerico :: Ord a => a -> a -> a
maxGenerico x y = 
    if x > y
        then x
        else y

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT = []
todosLosCaminos (NodeT x EmptyT EmptyT) = [[x]]
todosLosCaminos (NodeT x t1 t2) =
	agregarACadaSublista x (todosLosCaminos t1 ++ todosLosCaminos t2)

agregarACadaSublista :: a -> [[a]] -> [[a]]
agregarACadaSublista y [] = []
agregarACadaSublista y (xs:xss) =
	(y:xs) : agregarACadaSublista y xss

append :: ListApp a -> ListApp a -> ListApp a
append xs ys = Append xs ys

cons :: a -> ListApp a -> ListApp a
cons x xs = Append (Unit x) xs
            -- [x] ++ xs

-- Parcial en Unit
tail :: ListApp a -> ListApp a
-- tail (Unit x) = ...
tail (Append (Unit x) ys) = ys
tail (Append xs ys) = 
    Append (tail xs) ys

head :: ListApp a -> a
head (Unit x) = x
head (Append xs ys) = head xs

-- ExpArit simplificado
-- Hacer el de TP3
-- que es mas completo
data ExpArit =
      Num Int
    | Suma ExpArit ExpArit
    | Mult ExpArit ExpArit

eval :: ExpArit -> Int
eval (Num x) = x
eval (Suma e1 e2) = (eval e1) + (eval e2)
eval (Mult e1 e2) = (eval e1) * (eval e2)

simplificar :: ExpArit -> ExpArit
simplificar (Num x) = Num x
simplificar (Suma e1 e2) = simplificarSuma
            (simplificar e1) (simplificar e2)
simplificar (Mult e1 e2) = simplificarMult
    (simplificar e1) (simplificar e2)

simplificarSuma :: ExpArit -> ExpArit -> ExpArit
simplificarSuma (Num 0) e2 = e2
simplificarSuma e1 (Num 0) = e1
simplificarSuma e1 e2      = Suma e1 e2

simplificarMult :: ExpArit -> ExpArit -> ExpArit
simplificarMult (Num 0) e2 = Num 0
simplificarMult e1 (Num 0) = Num 0
simplificarMult (Num 1) e2 = e2
simplificarMult e1 (Num 1) = e1
simplificarMult e1 e2      = Mul e1 e2

-- Desafio, en anexo de TP1
agrupar :: Ord a => [a] -> [[a]]