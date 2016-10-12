import Queue

--Prop.: Cuenta la cantidad de elementos de la cola.
--Prec.: Ninguna.
largoQ :: Queue Int -> Int
largoQ c = 	if isEmptyQ c
			then 0
			else 1 + largoQ (dequeue c)
 

--Prop.: Dada una cola de personas, devuelve la lista de las mismas, donde el orden de la lista es de la cola.
--Prec.: 
atender :: Queue Persona -> [Persona]
atender c =	if isEmptyQ c
			then []
			else firstQ c : atender (dequeue c)
			

--(i) En el paso recursivo. Orden en que se insertan los elementos de la cola 2 en la 1.
--Prop.: Inserta todos los elementos de la segunda cola en la primera.
unirQ :: Queue a -> Queue a -> Queue a
unirQ c1 c2 =	if not (isEmptyQ c2)
				then unirQ (queue (firstQ c2) c1) (dequeue c2)
				else c1


--ALGUNOS EJEMPLOS PARA USAR CON QUEUE

data Persona = MKPersona Int String
personaEjem = MKPersona 2 "2"

p1 :: Queue Persona
p1 = queue (MKPersona 3 "3") (queue (MKPersona 2 "2") (queue (MKPersona 1 "1") (emptyQ)))

q1 :: Queue Int
q1 = queue 7 (queue 8 (queue 9 (queue 10 (queue 11 (queue 12 (emptyQ))))))

q2 :: Queue Int
q2 = queue 1 (queue 2 (queue 3 (queue 4 (queue 5 (queue 6 (emptyQ))))))

