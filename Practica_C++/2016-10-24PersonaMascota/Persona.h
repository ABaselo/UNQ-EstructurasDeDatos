#include <iostream>
#include "Mascota.h"

using namespace std;

struct PersonaRep {
  string nombre;
  int edad;
  Mascota mascota;
};

typedef PersonaRep* Persona;

Persona crearP(string nombre);

string getNombre(Persona p);
Mascota getMascota(Persona p);

void setMascota(Persona& p, Mascota m);

void crecer(Persona& p);
