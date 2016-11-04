#include "Persona.h"

Persona crearP(string nombre)
{
  PersonaRep* p = new PersonaRep;
  p->edad    = 0;
  p->nombre  = nombre;
  p->mascota = NULL;
  return p;
}

string getNombre(Persona p)
{
  return p->nombre;
}

Mascota getMascota(Persona p)
{
  return p->mascota;
}

void setMascota(Persona& p, Mascota m)
{
  p->mascota = m;
}

void crecer(Persona& p)
{
  p->edad++;
}
