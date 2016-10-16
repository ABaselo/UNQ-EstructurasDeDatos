module Celda(Celda, Color(Azul, Negro, Rojo, Verde), celdaVacia, poner, sacar, nroBolitas, hayBolitas) where
{-- Inv. Rep.:
	- Existe una clave para cada color existente.
	- El valor asociado a un color es un número positivo.
--}
import Map
import Maybe

data Color = Azul | Negro | Rojo | Verde
data Celda = MkCelda (Map Color Int)

instance Eq Color where
	Azul == Azul = True
	Negro == Negro = True
	Rojo == Rojo = True
	Verde == Verde = True
	_ == _ = False

-- **********
--  INTERFAZ:
-- **********

--Crea una celda con cero bolitas de cada color
celdaVacia :: Celda

--Agrega una bolita de ese color a la celda
poner :: Color -> Celda -> Celda

--Saca una bolita de ese color, parcial cuando no hay bolitas de ese color
sacar :: Color -> Celda -> Celda

--Devuelve la cantidad de bolitas de ese color
nroBolitas :: Color -> Celda -> Int

--Indica si hay bolitas de ese color
hayBolitas :: Color -> Celda -> Bool

-- *****************
--  IMPLEMENTACION:
-- *****************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(1)
celdaVacia = MkCelda (assocM (assocM (assocM (assocM emptyM Verde 0) Rojo 0) Negro 0) Azul 0)

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(2n)
poner c (MkCelda map) = MkCelda (assocM map c (cantidadDeBolitas c map + 1))

-- f aux: --

--O(n)
cantidadDeBolitas :: Color -> Map Color Int -> Int
cantidadDeBolitas c map = fromJust (lookupM map c)

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(2n)
sacar c  (MkCelda map) =	let cantBolitas = cantidadDeBolitas c map
							in	if cantBolitas > 0
								then MkCelda (assocM map c (cantBolitas - 1))
								else error "Boom!: No hay bolitas del color en la celda actual."
								
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(n)
nroBolitas c (MkCelda map) = cantidadDeBolitas c map

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(n)
hayBolitas c (MkCelda map) = cantidadDeBolitas c map > 0


