/*
 * main.cpp
 *
 *  Created on: 4 nov. 2016
 *      Author: aee
 */
#include "Lista.h"

int main()
{
	Lista ls = nil();
	cout << "Lista vacía: " << endl;
	cout << printLista(ls) << endl;

	cout << "isNil:" << endl;
	cout << isNil(ls) << endl << endl;

	cout << "Lista con un elemento agregado con cons: " << endl;
	cons(1, ls);
	cout << printLista(ls) << endl;

	cout << "isNil:" << endl;
	cout << isNil(ls) << endl;

	cout << "Lista con 5 elementos agregados con cons: " << endl;
	cons(2,ls);
	cons(3,ls);
	cons(4,ls);
	cons(5,ls);
	cout << printLista(ls) << endl;

	cout << endl << endl;
	ls = nil();

	cout << "Lista vacía: " << endl;
	cout << printLista(ls) << endl;

	cout << "Lista con un elemento agregado con snoc: " << endl;
	snoc(1,ls);
	cout << printLista(ls) << endl;

	cout << "Lista con 5 elementos agregados con snoc: " << endl;
	snoc(2,ls);
	snoc(3,ls);
	snoc(4,ls);
	snoc(5,ls);
	cout << printLista(ls) << endl << endl;

	cout << "Head de la lista: " << endl;
	cout << head(ls) << endl << endl;

	cout << "Tail de la lista:" << endl;

	cout << printLista(tail(ls)) << endl << endl;

	cout << "" << endl;
}



