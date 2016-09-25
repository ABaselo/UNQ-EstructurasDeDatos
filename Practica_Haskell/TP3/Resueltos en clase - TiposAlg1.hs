-- Expresiones lineales
-- Mala representacion
-- porque no representa
-- todas las expresiones posibles
-- Ej: (2+2) * (3+3)

-- Si representa 2*(3+3) o 3+(2*2)
data Expresion =
     Suma Int Expresion
   | Mult Int Expresion
   | Num  Int

cantSumas :: Expresion -> Int
cantSumas (Num _)    =  0
cantSumas (Suma _ e) =  1 + (cantSumas e)
cantSumas (Mult _ e) =  (cantSumas e)

eval :: Expresion -> Int
eval (Num n)    = n
eval (Suma n e) = n + (eval e)
eval (Mult n e) = n * (eval e)

numMayoresA :: Expresion -> Int -> [Int]
numMayoresA (Num n) y = 
	agregarSiMayorAN n y []

numMayoresA (Suma n e) y =
	agregarSiMayorAN n y (numMayoresA e y)

numMayoresA (Mult n e) y =
	agregarSiMayorAN n y (numMayoresA e y)


agregarSiMayorAN n e xs
	if n > y
	   then n : xs
	   else xs

-- Isomorfo a [a]
data Lista a = Vacio | Cons a (List a)

aLista :: [a] -> Lista a
aLista [] = Vacio
aLista (x:xs) = Cons x (aLista xs)

desdeLista :: Lista a -> [a]
desdeLista Vacio = []
desdeLista (Cons x xs) =
	x : desdeLista xs

-- Listas que no admiten vacio
-- Listas unitarias
data ListaNV a = Unit a | Cons a (ListaNV a)

minimoLNV :: ListaNV Int -> Int
minimoLNV (Unit x)    = x
minimoLNV (Cons x xs) =
	min x (minimoLNV xs)

minimo :: [Int] -> Int
-- Parcial en []
minimo [x] = x
minimo (x:xs) =
	min x (minimo xs)

-- Parcial en []
aListNV :: [a] -> ListaNV a

length [] = 0
length (x:xs) = 1 + length xs

lengthNV (Unit x) = 1
lengthNV (Cons x xs) =
	1 + (lengthNV xs)

append :: [a] -> [a] -> [a]
append [] ys     = ys
append (x:xs) ys = x : append xs ys

append :: ListaNV a -> ListaNV a -> ListaNV a
append (Unit x)    ys = Cons x ys
append (Cons x xs) ys =
	   Cons x (append xs ys)

-- Listas que representan
-- la agregacion con Snoc
data SnocList a = 
	  Vacio
	| Snoc (SnocList a) a

length :: SnocList a -> Int
length Vacio = 0
length (Snoc xs x) =
	1 + length xs

---- [1,2,3]
---- Snoc (Snoc (Snoc Vacio 1) 2) 3

toList :: SnocList a -> [a]
toList Vacio       = []
toList (Snoc xs x) =
	snoc (toList xs) x
    (toList xs) ++ [x]

toSnocList :: [a] -> SnocList a
toSnocList [] = Vacio
toSnocList xs = 
	Snoc (toSnocList (init xs)) (last xs)