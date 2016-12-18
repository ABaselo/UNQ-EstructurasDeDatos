#include <iostream>

using namespace std;

struct ClienteSt {
    string cuit;
    string nombre;

    int    cantidadPrendas;
    string plan;
};

typedef ClienteSt* Cliente;

// Prop.: crea un cliente dado un cuit y un nombre
Cliente crearCliente(string cuit, string nombre, string plan);

// Prop.: devuelve el cuit de un cliente
string getCuit(Cliente c);

// Prop.: devuelve el nombre de un cliente
string getNombre(Cliente c);

// Prop.: libera la memoria de un cliente
void destroyCliente(Cliente& c);

// Prop.: imprime a un cliente
void printCliente(Cliente c);

/**
INTERFAZ EXTENDIDA
**/

// Prop.: devuelve la cantidad de prendas de un cliente
int  getCantidadPrendas(Cliente c);

// Prop.: aumenta la cantidad de prendas de un cliente
void aumentarPrendas(Cliente& c, int cantidad);

// Prop.: disminuye la cantidad de prendas de un cliente
void disminuirPrendas(Cliente& c, int cantidad);

// Prop.: devuelve el plan de un cliente
string getPlan(Cliente& c);

// Prop.: asigna un plan a un cliente
void setPlan(Cliente& c, string plan);
