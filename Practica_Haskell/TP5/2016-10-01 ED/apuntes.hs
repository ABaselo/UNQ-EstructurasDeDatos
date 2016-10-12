--PROPOSITO: Dada una direccion y un tablero , la celda actual para a ser la que se encuentra contifua a la actual en la direccion especificada. Si no se cumple la precondicion se lanza un BOOM.
--PRECONDICION: La celda a la que me quiero mover debe existir.
mover :: Dir -> Tablero -> Tablero
mover dir t@(MkTablero mapCeldas actual) =	if puedeMover dir t
											then MkTablero mapCeldas (moverCelda dir actual)
											else error "BOOM - Te caiste del tablero."
											
moverCelda :: Dir -> Coordenada -> Coordenada
moverCelda Norte (MkCoord x y) = MkCoord x (y+1)
moverCelda Sur (MkCoord x y) = MkCoord x (y-1)
moverCelda Este (MkCoord x y) = MkCoord (x+1) y
moverCelda Oeste (MkCoord x y) = MkCoord (x-1) y

puedeMover :: Dir -> Tablero -> Bool
puedeMover dir (MkTablero mapCeldas actual) = ! isNothing (lookupM (moverCelda dir actual))

--												belong (moverCelda dir actual) (domM mapCeldas)

sacar :: Color -> Tablero -> Tablero
sacar color (MkTablero mapCeldas actual) =	let celdaActual = (buscarCeldaEnMap mapCeldas actual)
											if hayBolitas color celdaActual
											then MkTablero (assocM actual (sacarEnCelda color celdaActual) mapCeldas) actual
											else error "BOOM"

sacarEnCelda :: Color -> Celda -> Celda
sacarEnCelda Azul (MkCelda a n r v) = (MkCelda (a-1) n r v)
	.
	.
	.
	.
	
	
--PRECONDICIONES: La celda existe en el map.
buscarCeldaEnMap :: Map Coordenada Celda -> Coordenada -> Celda
buscarCeldaEnMap mapCeldas coord = fromJust (lookUpM)
