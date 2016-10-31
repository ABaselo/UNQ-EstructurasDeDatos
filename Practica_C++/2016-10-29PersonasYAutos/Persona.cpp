#include "Personas.h"

Persona crearPersona(string nombre, int edad){
    Persona p = new PersonaSt;

    p->nombre=nombre;
    p->edad=edad;

    return p;
}

string getNombre(Persona p){
    return p->nombre;
}

int getEdad(Persona p){
    return p->edad;
}

void crecer(Persona& p){
    p->edad++;
}

void muere(Persona& p){
    delete p;
    p = NULL;
}

