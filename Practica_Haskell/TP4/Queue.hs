module Queue (Queue, emptyQ , isEmptyQ, queue, firstQ, dequeue, lenQ, example) where


--Queue
data Queue a = MkQ [a]

example :: Queue Int
example = queue 3 (queue 2 (queue 1 (MkQ [])))

--Crea una cola vacía.
emptyQ :: Queue a
emptyQ = MkQ []


--Dada una cola indica si la cola está vacía.
isEmptyQ :: Queue a -> Bool
isEmptyQ (MkQ []) = True
isEmptyQ _ = False

--Dados un elemento y una cola, agrega ese elemento a la cola.
queue :: a -> Queue a -> Queue a
queue e (MkQ es) = MkQ (es ++ [e])
 
--Dada una cola devuelve el primer elemento de la cola.
--Prec.: La COLA no debe ser vacía.
firstQ :: Queue a -> a
firstQ (MkQ es) = head es

--Dada una cola la devuelve sin su primer elemento.
--Prec.: La COLA no debe ser vacía.
dequeue :: Queue a-> Queue a
dequeue (MkQ es) = MkQ (tail es)

--Cuenta la cantidad de elementos de la cola.
--Prec.: Ninguna
lenQ :: Queue a -> Int
lenQ (MkQ [])= 0
lenQ (MkQ (e:es)) = 1 + lenQ (MkQ es)


