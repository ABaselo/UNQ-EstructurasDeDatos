import Maybe

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

isEmptyT EmptyT = True
isEmptyT _      = False

-- Dado un BST y un elemento, devuelve el máximo elemento que sea menor al elemento dado.
-- Precondición: 
--  El árbol tiene que tener por lo menos un elemento menor a "n" y ser BST
elMaximoMenorA :: Ord a => a -> Tree a -> a
elMaximoMenorA n EmptyT = error "no hay maximo menor al nro pedido"
elMaximoMenorA n (NodeT x t1 t2) = 
    if x < n
       then elMaximoMenorACC n x t2
       else elMaximoMenorA n t1

-- Lo mismo dado que hay un "candidato" posible
elMaximoMenorACC :: Ord a => a -> a -> Tree a -> a
elMaximoMenorACC n c EmptyT = c
elMaximoMenorACC n c (NodeT x t1 t2) = 
    if x < n
       then elMaximoMenorACC n x t2
       else elMaximoMenorACC n c t1

-- Dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al elemento dado.
-- Precondición: 
--  El árbol tiene que tener por lo menos un elemento mayor a "n" y ser BST
elMinimoMayorA :: Ord a => a -> Tree a -> a
elMinimoMayorA n EmptyT = error "no hay minimo mayor al nro pedido"
elMinimoMayorA n (NodeT x t1 t2) = 
    if x > n
       then elMinimoMayorACC n x t1
       else elMinimoMayorA n t2

-- Lo mismo dado que hay un "candidato" posible
elMinimoMayorACC :: Ord a => a -> a -> Tree a -> a
elMinimoMayorACC n c EmptyT = c
elMinimoMayorACC n c (NodeT x t1 t2) = 
    if x > n
       then elMinimoMayorACC n x t1
       else elMinimoMayorACC n c t2
