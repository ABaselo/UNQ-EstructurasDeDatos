import Map
import Maybe
import Celda

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(n)
--Devuelve True si hay más de 'n' bolitas de ese color
nroBolitasMayorA :: Color -> Int -> Celda -> Bool
nroBolitasMayorA col n celda = (nroBolitas col celda) > n

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- ¿O(nxm)?
--Agrega 'n' bolitas de ese color a la celda
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 _ celda = celda
ponerN n col celda = ponerN (n-1) col (poner col celda)

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--O(4n)
--Indica si existe al menos una bolita de cada color posible
hayBolitasDeCadaColor :: Celda -> Bool
hayBolitasDeCadaColor celda = 	hayBolitas Azul celda &&
								hayBolitas Negro celda &&
								hayBolitas Rojo celda &&
								hayBolitas Verde celda

