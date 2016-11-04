#include <iostream>
#include "auto.h"

using namespace std;

int main()
{
/*    cout << "TEST DE PERSONAST:" << endl;

    Persona juan = crearPersona("Juan", 25);
    cout << "Su nombre es: " << getNombre(juan) << endl;
    cout << "Su edad es: " << getEdad(juan) << endl;
    crecer(juan);
    cout << "Su edad nueva es: " << getEdad(juan) << endl;
    muere(juan);
    cout << "Edad después de morir edad es: " << getEdad(juan) << endl; //Tira segmentation fault. Le estoy pidiendo el campo a null.
*/
    cout << "TEST DE AUTOST:" << endl;

    Auto a = crearAutoVacio();// Auto a es lo mismo que AutoSt* a. Es decir, 'a' es un puntero.

    cout << "El auto tiene al piloto y copiloto: " << a->piloto << ", " << a->copiloto << endl << endl;

//  CARGO EL PILOTO:
    Persona pil = new PersonaSt();
    pil->nombre = "PILOTO";
    subirPiloto(a, pil);

    cout << "AHORA CARGO AL PILOTO: " << endl;
    cout << "El auto tiene al piloto y copiloto: " << a->piloto->nombre << ", " << a->copiloto << endl << endl;

//  CARGO EL COPILOTO:
    Persona copil = new PersonaSt();
    copil->nombre = "CO-PILOTO";
    subirCopiloto(a, copil);

    cout << "AHORA CARGO AL CO-PILOTO: " << endl;
    cout << "El auto tiene al piloto y copiloto: " << a->piloto->nombre << ", " << a->copiloto->nombre << endl << endl;

//  CHOCO EL AUTO:
    chocaElAutoYExplotaTodo(a);

    cout << "CHOCO EL AUTO: " << endl;
    cout << "El auto apunta a: " << a << endl << endl;
    cout << "La persona piloto quedo en: " << pil << endl;
    cout << "La persona co-piloto quedo en: " << copil << endl;
    return 0;
}
