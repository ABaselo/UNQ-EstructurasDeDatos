/*
 * Pokemon.cpp
 *
 *  Created on: 2 nov. 2016
 *      Author: aee
 */
#include <iostream>
#include "Pokemon.h"

Pokemon crearPokemon(string nombre){
	Pokemon p = new PokemonSt;
	p->nombre = nombre;
	p->vida = 100;

	return p;
};

void restarVida(Pokemon& p){
	p->vida = 0;
};

void cambiarNombre(Pokemon& p, string nombre){
	p->nombre = nombre;
};

bool estaVivo(Pokemon p){
	return p->vida > 0;
};

string getNombre(Pokemon p){
	return p->nombre;
};

int getVida(Pokemon p){
	return p->vida;
};

void destruir(Pokemon& p){
	delete p;
	p = NULL;
};
