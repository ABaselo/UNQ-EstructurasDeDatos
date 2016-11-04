/*
 * main.cpp
 *
 *  Created on: 2 nov. 2016
 *      Author: aee
 */
#include "Fraccion.h"

int main() {
	FraccionSt* f1 = fraccion(512,5);
	Fraccion f2	   = fraccion(20,21);

	Fraccion suma = sumar(f1,f2);

	mostrarFraccion(suma);

	destruir(suma);
	destruir(f1);
	destruir(f2);
}

