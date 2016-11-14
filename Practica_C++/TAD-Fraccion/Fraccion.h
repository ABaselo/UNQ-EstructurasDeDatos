/*
 * Fraccion.h
 *
 *  Created on: 2 nov. 2016
 *      Author: aee
 */
#include <iostream>
using namespace std;//std namespace en que permite traer a string, vector, etc..

struct FraccionSt{
	int numerador;
	int denominador;
};

typedef FraccionSt* Fraccion;

Fraccion fraccion(int x, int y);

Fraccion sumar(Fraccion f1, Fraccion f2);

Fraccion restar(Fraccion f1, Fraccion f2);

Fraccion multiplicar(Fraccion f1, Fraccion f2);

Fraccion dividir(Fraccion f1, Fraccion f2);

void invertir(Fraccion& f1);

void simplificar(Fraccion& f);


void destruir(Fraccion& f1);

//Estás función no debería estar en la interface.
void simplificarConN(int n, Fraccion& f);

void mostrarFraccion(Fraccion f);




