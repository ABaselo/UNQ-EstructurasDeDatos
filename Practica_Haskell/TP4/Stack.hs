module Stack (Stack, emptyS, isEmptyS, push, top, pop) where

data Stack a = MkS [a]

--Prop.: Crea una pila vacía.
emptyS :: Stack a
emptyS = MkS []

--Prop.: Dada una pila indica si está vacía.
isEmptyS :: Stack a -> Bool
isEmptyS (MkS []) = True
isEmptyS stk = False

--Prop.: Dados un elemento y una pila, agrega el elemento a la pila.
push :: a -> Stack a -> Stack a
push e (MkS xs) = MkS (e:xs)

--Prop.: Dada un pila devuelve el elemento del tope de la pila.
top :: Stack a -> a
top (MkS xs) = head xs

--Prop.: Dada una pila devuelve la pila sin el primer elemento.
pop :: Stack a -> Stack a
pop (MkS xs) = MkS (tail xs)
