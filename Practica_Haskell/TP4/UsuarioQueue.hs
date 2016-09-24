import Queue

--Prop.: Cuenta la cantidad de elementos de la cola.
--Prec.: Ninguna.
largoQ :: Queue Int -> Int
largoQ c = 	if isEmptyQ c
			then 0
			else 1 + largoQ (dequeue c)
 

data Persona = MKPersona Int String
personaEjem = MKPersona 2 "2"

examplePersonas :: Queue Persona
examplePersonas = queue (MKPersona 3 "3") (queue (MKPersona 2 "2") (queue (MKPersona 1 "1") (emptyQ)))

--Prop.: Dada una cola de personas, devuelve la lista de las mismas, donde el orden de la lista es de la cola.
--Prec.: 
--atender :: Queue Persona -> [Persona]
--atender c =	if isEmptyQ c
--			then []
--			else firstQ c : dequeue c
