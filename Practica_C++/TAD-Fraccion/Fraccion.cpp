/*
 * Fraccion.cpp
 *
 *  Created on: 2 nov. 2016
 *      Author: aee
 */
#include <iostream>
#include "Fraccion.h"

Fraccion fraccion(int x, int y){
	Fraccion f = new FraccionSt;
	f->numerador = x;
	f->denominador = y;
	return f;
};

Fraccion sumar(Fraccion f1, Fraccion f2){
	Fraccion suma = new FraccionSt;
	suma->numerador = (f1->numerador * f2->denominador) + (f2->numerador * f1->denominador);
	suma->denominador = f1->denominador * f2->denominador;

	simplificar(suma);

	return suma;
};

Fraccion restar(Fraccion f1, Fraccion f2){
	return NULL;
};

Fraccion multiplicar(Fraccion f1, Fraccion f2){
	return NULL;
};

Fraccion dividir(Fraccion f1, Fraccion f2){
	return NULL;
};

void invertir(Fraccion& f1){

};

//Lo estoy resolviendo por recursión. Me estoy complicando la vida apropósito para comparar
//la recursión de haskell y c++.
void simplificar(Fraccion& f){
	simplificarConN(2, f);
};

void simplificarConN(int n, Fraccion& f) {
//	cout << n << endl;
	if(n <= f->numerador && n <= f->denominador) { //cuando n sea mayor al numerador o denominador de la fracción la recursión termina
		if((f->numerador % n)==0 && (f->denominador% n)==0){//compruebo si tanto el denominador y numerador son divisibles por n
			f->numerador = f->numerador / n;
			f->denominador = f->denominador / n;
			simplificarConN(n, f);
		}
		else{
			simplificarConN(n+1, f);
		}
	}
};

void destruir(Fraccion& f1){
	delete f1;
	f1 = NULL;
};

void mostrarFraccion(Fraccion f){
	int num = f->numerador;
	int den = f->denominador;
	cout << " " << num << "/" << den << endl;
};



