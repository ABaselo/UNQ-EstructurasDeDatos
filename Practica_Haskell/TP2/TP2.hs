-- 1 - TIPOS DE DATOS DEFINIDOS POR EL USUARIO
----------------------------------------------

--1.

--	1)
--Propósito: 

data Dir = Norte | Sur | Este | Oeste

opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Este = Oeste
opuesto Oeste = Este

siguiente :: Dir -> Dir
siguiente Norte = Este
siguiente Este = Sur
siguiente Sur = Oeste
siguiente Oeste = Norte


--	2)
--Propósito:
type Edad = Int
type Nombre = String
data Persona = MKPersona Nombre Edad

instance Eq Persona where
	p1 == p2 = (edad p1) == (edad p2) && (nombre p1) == (nombre p2)
	p1 /= p2 = not (p1 == p2)

instance Ord Persona where
	p1 > p2 = (edad p1) > (edad p2)
	p1 < p2 = (edad p1) < (edad p2)
	p1 >= p2 = (edad p1) >= (edad p2)
	p1 <= p2 = (edad p1) <= (edad p2)
	
nombre :: Persona -> Nombre
nombre (MKPersona n _) = n


edad :: Persona -> Edad
edad (MKPersona _ e) = e



crecer :: Persona -> Persona
crecer p = MKPersona (nombre p) (1 + edad p)

cambioNombre :: String -> Persona -> Persona
cambioNombre n p = MKPersona n (edad p)

esMenorQueLaOtra :: Persona -> Persona -> Bool
esMenorQueLaOtra p1 p2 =	if p1 < p2 then
								True
							else
								False
								
mayoresA :: Int -> [Persona] -> [Persona]

mayoresA e [] = []
mayoresA e (p:ps) =	if (edad p) > e then
						p:mayoresA e ps
					else
						mayoresA e ps
						
promedioEdad :: [Persona] -> Int

promedioEdad ps = div (sumarEdades ps) (length ps)

sumarEdades :: [Persona] -> Int

sumarEdades [] = 0
sumarEdades (p:ps) = edad p + sumarEdades ps

--Propósito: Dada una lista de personas, retorna la persona de mayor edad. Si hay varias personas que mayores que tienen la misma edad se devuelve una de ellas.
--Precondición: La lista no debe estar vacía.
elMasViejo :: [Persona] -> Persona

elMasViejo (p:ps) = if esMayorDeLaLista p ps then
						p
					else
						elMasViejo ps
						
esMayorDeLaLista :: Persona -> [Persona] -> Bool

esMayorDeLaLista p [] = True
esMayorDeLaLista p1 (p:ps) = (p1 >= p) && esMayorDeLaLista p1 ps


--	3)
data TipoDePokemon = Agua | Fuego | Planta
data Pokemon = MKPokemon TipoDePokemon Energia
data Entrenador = MKEntrenador Nombre [Pokemon]

type Energia = Int


elementoGanador :: TipoDePokemon -> TipoDePokemon

elementoGanador Fuego = Agua
elementoGanador Planta = Fuego
elementoGanador Agua = Planta

instance Eq TipoDePokemon where
	Fuego == Fuego = True
	Planta == Planta = True
	Agua == Agua = True
	_ == _ = False


leGanaA :: Pokemon -> Pokemon -> Bool

leGanaA (MKPokemon t1 e1) (MKPokemon t2 e2) = t1 == elementoGanador t2


capturaPokemon :: Pokemon -> Entrenador -> Entrenador

capturaPokemon p (MKEntrenador n ps) = MKEntrenador n (p:ps)


cantidadDePokemons :: Entrenador -> Int

cantidadDePokemons (MKEntrenador n ps) = length ps



cantidadDePokemonsDeTipo :: TipoDePokemon -> Entrenador -> Int

cantidadDePokemonsDeTipo _ (MKEntrenador _ []) = 0
cantidadDePokemonsDeTipo t (MKEntrenador n (p:ps)) =	if pokemonEsDeTipo p t then
														1 + cantidadDePokemonsDeTipo t (MKEntrenador n ps)
													else
														cantidadDePokemonsDeTipo t (MKEntrenador n ps)


pokemonEsDeTipo :: Pokemon -> TipoDePokemon -> Bool

pokemonEsDeTipo (MKPokemon t e) t1 = t == t1


lePuedeGanar :: Entrenador -> Pokemon -> Bool

lePuedeGanar (MKEntrenador _ []) _ = False
lePuedeGanar (MKEntrenador n (p:ps)) p1 = leGanaA p p1 || lePuedeGanar (MKEntrenador n ps) p1



puedenPelear :: TipoDePokemon -> Entrenador -> Entrenador -> Bool

puedenPelear t e1 e2 = (cantidadDePokemonsDeTipo t e1) >= 1 && (cantidadDePokemonsDeTipo t e2) >= 1



esExperto :: Entrenador -> Bool

esExperto e = (cantidadDePokemonsDeTipo Fuego e) >= 1 && (cantidadDePokemonsDeTipo Agua e) >= 1 && (cantidadDePokemonsDeTipo Planta e) >= 1



fiestaPokemon :: [Entrenador] -> [Pokemon]

fiestaPokemon [] = []
fiestaPokemon (e:es) = pokemonsDeEntrenador e ++ fiestaPokemon es



pokemonsDeEntrenador :: Entrenador -> [Pokemon]

pokemonsDeEntrenador (MKEntrenador n ps) = ps
