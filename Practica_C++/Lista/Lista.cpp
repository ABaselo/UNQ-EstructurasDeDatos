/*
 * Lista.cpp
 *
 *  Created on: 4 nov. 2016
 *      Author: aee
 */
#include <iostream>
#include <sstream>
#include "Lista.h"

namespace patch
{
    template < typename T > std::string to_string( const T& n )
    {
        std::ostringstream stm ;
        stm << n ;
        return stm.str() ;
    }
}


/*	INVARIANTE DE REPRESENTACIÓN:
 * 	----------------------------
		* Cada nodo posee un valor y un puntero al siguiente nodo (siguiente elemento de la lista).
  		* NULL == lista vacía.
  		* El último nodo de la lista es un puntero a la lista vacía (NULL).
*/

struct LNode
{
	LNode* next;
	int value;
};

Lista nil()
{
	return NULL;
}

void cons(int n, Lista& ns)
{
	Lista node = new LNode;
	node->value = n;
	node->next = ns;

	ns = node;
}

void snoc(int n, Lista& ns)
{
	if(isNil(ns))
	{
		cons(n,ns);
	}
	else
	{
		Lista currentNode = ns;

		while(not isNil(currentNode->next) )
		{
			currentNode = currentNode->next;
		}

		Lista node = new LNode;
		currentNode->next = node;

		node->value = n;
		node->next = NULL;

//		cout << "Nodo dir " << currentNode << ": [" << currentNode->value << ",(" << currentNode->next <<")]" << endl;
	}
}

int head(Lista ns)
{
	return ns->value;
}

Lista tail(Lista ns)
{
	return ns->next;
}

bool isNil(Lista ns)
{
	return ns == NULL;
}

string printLista(Lista ls)
{
	std::string lista = "";
	Lista pNode = ls;
	while(not isNil(pNode))
	{
		lista += patch::to_string(pNode->value);
		pNode = pNode->next;
		if(not isNil(pNode))
			lista += ", ";
	}
	return "[ " + lista + " ]";
}


