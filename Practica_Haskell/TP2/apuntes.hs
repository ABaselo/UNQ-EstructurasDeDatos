crecer :: Persona -> Persona
crecer (MKPersona n e) = MKPersona n (e + 1)

data Persona = MKPersona Nombre Edad

type Nombre = String
type Edad = Int

--Funciones constructores
-------------------------

nacer :: Nombre -> Persona
nacer n = MKPersona n o

--Funciones de acceso
---------------------

edad :: Persona -> Edad
edad (MKPersona _ e) = e
nombre : Persona -> Nombre
nombre (MKPersona n _) = n



--------------------------------------
--Precondición: La lista no puede ser vacía
elMasViejo :: [Persona] -> Persona
elMasViejo [p] = p
elMasViejo (p:ps) = elMayor p (elMasViejo)

elMayor :: Persona -> Persona -> Persona
elMayor p1 p2 = if p1 > p2 then
					p1
				else
					p2
					
instance Ord Persona where
p1 > p2 = (edad p1) > (edad p2)
p1 < p2 = (edad p1) < (edad p2)
p1 >= p2 = (edad p1) >= (edad p2)
p1 <= p2 = (edad p1) <= (edad p2)

instance Eq Persona where
p1 == p2 = (edad p1) == (edad p2) && (nombre p1) == (nombre p2)
p1 /= p2 = not (p1 == p2)


apariciones :: Eq a => a -> [a] -> Int
apariciones _ [] = 
apariciones e (x:xs) =	if x == e then
							1 + apariciones e xs
						else
							apariciones e xs
							
cantidadDePokemonIgualesA :: Entrenador -> Pokemon -> Int

cantidadDePokemonIgualesA (MKEntrenador n ps) p = apariciones p ps


--:set -u
