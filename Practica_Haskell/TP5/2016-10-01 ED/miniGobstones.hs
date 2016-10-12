import Map

data Dir = Norte | Sur | Este | Oeste
data Color = Azul | Negro | Rojo | Verde
data Coordenada = MkCoord Int Int
data Celda = MkCelda Int Int Int Int 
data Tablero = MkTablero (Map Coordenada Celda) Coordenada

poner :: Color -> Tablero -> Tablero
poner col (MkTablero m ca) = MkTablero (ponerEnMap m col ca) ca

ponerEnMap :: Map Coordenada Celda -> Color -> Coordenada -> Map Coordenada Celda
ponerEnMap map col ca = assocM ca (ponerColorEnCelda (fromJust (lookUpM ca map)) col) map 

ponerColorEnCelda :: Celda -> Color -> Celda
ponerColorEnCelda (MkCelda a n r v) Azul = MkCelda (a+1) n r v 
ponerColorEnCelda (MkCelda a n r v) Negro = MkCelda a (n+1) r v
ponerColorEnCelda (MkCelda a n r v) Rojo = MkCelda a n (r+1) v
ponerColorEnCelda (MkCelda a n r v) Verde = MkCelda a n r (v+1)

sacar :: Color -> Tablero -> Tablero
sacar col (MkTablero map ca) = 	let celda = fromJust (lookUpM ca map)
								in
									if hayBolitasEnCelda col celda
									then MkTablero (assocM ca (sacarColorEnCelda celda col) map) ca
									else error "BOOM!"

sacarColorEnCelda :: Celda -> Color -> Celda
sacarColorEnCelda (MkCelda a n r v) Azul 	= MkCelda (a-1) n r v
sacarColorEnCelda (MkCelda a n r v) Negro 	= MkCelda a (n-1) r v
sacarColorEnCelda (MkCelda a n r v) Rojo 	= MkCelda a n (r-1) v
sacarColorEnCelda (MkCelda a n r v) Azul 	= MkCelda a n r (v-1)

hayBolitas :: Color -> Tablero -> Bool
hayBolitas color (MkTablero map ca) = hayBolitasEnCelda color (fromJust (lookUpM ca map))

hayBolitasEnCelda :: Color -> Celda -> Bool
hayBolitasEnCelda Azul (MkCelda a _ _ _) = a > 0
hayBolitasEnCelda Negro (MkCelda _ n _ _) = n > 0
hayBolitasEnCelda Rojo (MkCelda _ _ r _) = r > 0
hayBolitasEnCelda Verde (MkCelda _ _ _ v) = v > 0

------------------------------------------------------------------------------------------------
--Main> t2x2
--MkTablero (MkM [MkCoord 1 1,MkCoord 1 1,MkCoord 1 1,MkCoord 1 1] [MkCelda 0 0 0 0,MkCelda 0 0 0 0,MkCelda 0 0 0 0,MkCelda 0 0 0 0]) (MkCoord 0 0)
--Main> mover Norte t2x2
--{error "BOOM!: No existe la celda en la direcci\243n dada."}


mover :: Dir -> Tablero -> Tablero
mover dir t@(MkTablero map ca) = 	if puedoMover dir t
									then MkTablero map (moverADir dir ca)
									else error "BOOM!: No existe la celda en la dirección dada."

puedoMover :: Dir -> Tablero -> Bool
puedoMover dir (MkTablero map ca) = existeCoordenada (moverADir dir ca) (domM map)

existeCoordenada :: Coordenada -> [Coordenada] -> Bool
existeCoordenada coord [] = False
existeCoordenada coord (c:cs) = coord == c || existeCoordenada coord cs

moverADir :: Dir -> Coordenada -> Coordenada
moverADir Norte (MkCoord x y) = MkCoord x (y+1)
moverADir Este 	(MkCoord x y) = MkCoord (x+1) y
moverADir Sur	(MkCoord x y) = MkCoord x (y-1)
moverADir Oeste	(MkCoord x y) = MkCoord (x-1) y
----------------------------------------------------------------------

instance Eq Coordenada where
	(MkCoord x1 y1) == (MkCoord x2 y2) = x1 == x2 && y1 == y2

fromJust :: Maybe a -> a
fromJust (Just x) = x


--EJEMPLOS

ej1 :: Tablero
ej1 = MkTablero ((assocM (MkCoord 0 0) (MkCelda 0 0 0 0) emptyM)) (MkCoord 0 0)

t2x2 :: Tablero
t2x2 = MkTablero (assocM (MkCoord 1 1) (MkCelda 0 0 0 0) (assocM (MkCoord 1 0) (MkCelda 0 0 0 0) (assocM (MkCoord 0 1) (MkCelda 0 0 0 0) (assocM (MkCoord 0 0) (MkCelda 0 0 0 0) emptyM)))) (MkCoord 0 0)

