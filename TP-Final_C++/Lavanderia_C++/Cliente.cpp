#include "Cliente.h"

/*
INVARIANTE DE REPRESENTACION
----------------------------
    * Un cliente nunca es NULL;
    * La cantidad de prendas es siempre mayor o igual a cero.
*/


/**
Prop.: Crea un nuevo cliente y lo retorna.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Crea la estructura de un cliente y se retorna.
Cliente crearCliente(string cuit, string nombre, string plan) {
    ClienteSt* c = new ClienteSt;
    c->cuit = cuit;
    c->nombre = nombre;
    c->cantidadPrendas = 0;
    c->plan = plan;
    return c;
}

/**
Prop.: Retorna el CUIT del cliente dado.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Retorna un valor de la estructura del cliente.
string getCuit(Cliente c) {
    return c->cuit;
}

/**
Prop.: Retorna el nombre del cliente dado.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Retorna un valor de la estructura del cliente.
string getNombre(Cliente c) {
    return c->nombre;
}

/**
Prop.: Destruye el cliente dado.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Se libera la memoria del cliente dado.
void destroyCliente(Cliente& c) {
    delete c;
    c = NULL;
}

void printCliente(Cliente c) {
    cout << "Cliente {" << endl;
    cout << "  cuit: " << c->cuit << endl;
    cout << "  nombre: " << c->nombre << endl;
    cout << "  cantidad: " << c->cantidadPrendas << endl;
    cout << "  plan: " << c->plan << endl;
    cout << "}" << endl;
}

/**
  INTERFAZ EXTENDIDA
**/

/**
Prop.: Devuelve la cantidad de prendas de un cliente.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Retorna un valor de la estructura del cliente.
int  getCantidadPrendas(Cliente c) {
    return c->cantidadPrendas;
}

/**
Prop.: Aumenta la cantidad de prendas de un cliente.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Actualiza un valor de la estructura del cliente.
void aumentarPrendas(Cliente& c, int cantidad)  {
    c->cantidadPrendas += cantidad;
}

/**
Prop.: Disminuye la cantidad de prendas de un cliente.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Actualiza un valor de la estructura del cliente.
void disminuirPrendas(Cliente& c, int cantidad) {
    c->cantidadPrendas -= cantidad;
}

/**
Prop.: Devuelve el plan de un cliente.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Retorna un valor de la estructura del cliente.
string getPlan(Cliente& c) {
    return c->plan;
}

/**
Prop.: Asigna un plan a un cliente.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Asigna un valor de la estructura del cliente.
void setPlan(Cliente& c, string plan) {
    c->plan = plan;
}
