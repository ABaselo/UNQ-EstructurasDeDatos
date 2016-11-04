#include "Mascota.h"

Mascota crearM(string nombre, string tipo)
{
  MascotaRep* m = new MascotaRep;
  m->nombre = nombre;
  m->tipo   = tipo;
  return m;
}

string getNombreM(Mascota m)
{
  return m->nombre;
}

string getTipoM(Mascota m)
{
  return m->tipo;
}

void cambiarNombre(Mascota& m, string nombre)
{
  m->nombre = nombre;
}
