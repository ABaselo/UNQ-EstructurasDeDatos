#include <iostream>
#include <stdlib.h>
#include "Cliente.h"
#include "ArrayList.h"

using namespace std;

struct AVLNode {
    int height;
    AVLNode* left;
    AVLNode* right;
    Cliente kv;
};

typedef AVLNode* AVL;

typedef AVL Map;

// Prop.: crea un Map vacio
Map emptyM();

// Prop.: asocia un cuit con un cliente
void addM(Map& m, Cliente c);

// Prop.: devuelve un cliente dado un cuit
Cliente lookupM(Map& m, string cuit);

// Prop.: indica si la respuesta del lookup es válida
bool isNothing(Cliente c);

// Prop.: elimina un cliente dado un cuit
void removeM(Map& m, string cuit);

// Prop.: devuelve la lista de claves de un Map
ArrayList domM(Map& m);

void printMap(Map m);

// Prop.: libera la memoria de un Map
void destroyM(Map& m);
