#include <iostream>

using namespace std;

struct MascotaRep {
  string nombre;
  string tipo;
};

typedef MascotaRep* Mascota;

Mascota crearM(string nombre, string tipo);

string getNombreM(Mascota m);
string getTipoM(Mascota m);

void cambiarNombre(Mascota& m, string nombre);




