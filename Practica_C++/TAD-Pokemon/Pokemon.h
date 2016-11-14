/*
 * Pokemon.h
 *
 *  Created on: 2 nov. 2016
 *      Author: aee
 */
#include <iostream>
using namespace std;

struct PokemonSt{
	int vida;
	string nombre;
};

//defino PokemonSt* como Pokemon
typedef PokemonSt* Pokemon;

Pokemon crearPokemon(string nombre);

void restarVida(Pokemon& p);

void cambiarNombre(Pokemon& p, string nombre);

bool estaVivo(Pokemon p);

string getNombre(Pokemon p);

int getVida(Pokemon p);

void destruir(Pokemon& p);

/*
void luchar(Pokemon& p, Pokemon& r);

void lucharN(int n, Pokemon& p, Pokemon& r);
*/


