#include <iostream>
using namespace std;

/*INTERFAZ DESTRUCTIVA DE LISTAS*/

struct LNode;

typedef LNode* Lista;


Lista nil();

void cons(int n, Lista& ns);

void snoc(int n, Lista& ns);

int head(Lista ns);

Lista tail(Lista ns);

bool isNil(Lista ns);

string printLista(Lista ls);
