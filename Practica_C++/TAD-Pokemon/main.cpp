#include <iostream>
#include "Pokemon.h"

using namespace std;

int main(){

	//CREAR POKEMON:
	/*
	PokemonSt* p = crearPokemon("Pikachu");

	cout << "El nombre del pokemon creado es: " << p->nombre << endl;
	cout << "La vida de " << p->nombre << " es de: " << p->vida << endl;

	cout << "Antes del delete el pokemon creado apunta a " << p << endl;

	delete p;// libero la posición de memoria apuntada por 'p'. El sis.op. ahora puede sobreescribir esa celda.
	p = NULL;// asigno al puntero 'p' la direccion de memoria NULL (NULL es representado por 0)

	cout << "ahora después del delete apunta a : " << p << endl;

	*/
	//RESTAR VIDA:
	/*
	PokemonSt* p = crearPokemon("Pikachu");
	restarVida(p);
	cout << "Le resto vida a Pikachu (le seteo la vida en 0): " << p->vida << endl;
	*/

	//CAMBIAR NOMBRE:
	/*
	PokemonSt* p = crearPokemon("Pikachu");
	cout << "Nombre del pokemon antes de cambiarle el nombre: " << p->nombre << endl;
	cambiarNombre(p, "Raichu");
	cout << "después de cambiarle el nombre: " << p->nombre << endl;
	delete p;
	p = NULL;
	*/

	//ESTA VIVO EL POKEMON:
	/*
	PokemonSt* p = crearPokemon("Pikachu");
	cout << "¿Pikachu está vivo?. RST.(1=SI, 0=NO): " << estaVivo(p) << endl;
	delete p;
	p = NULL;
	*/

	//GETTERS DE POKEMON:
	/*
	Pokemon p = crearPokemon("Pikachu");
	cout << "getNombre: \"" << getNombre(p) << "\" getVida: " << getVida(p) << endl;
	delete p;
	p = NULL;
	*/

	//DESTRUIR:
	/*
	PokemonSt* p = new PokemonSt;

	cout << "Antes de destruir:" << endl;
	cout << "El puntero 'p' con dirección de memoria " << &p << " apunta al valor " << p << endl;
	destruir(p);

	cout << "Después de destruir:" << endl;
	cout << "El puntero 'p' con dirección de memoria " << &p << " apunta al valor " << p << endl;
	*/
	return 0;
}
