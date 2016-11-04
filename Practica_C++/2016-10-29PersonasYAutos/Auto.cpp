#include "auto.h"

Auto crearAutoVacio(){
//  Auto a;//A la posición de memoria apuntada por el puntero 'a' la dejo reservada para luego almacenar un AutoSt.
    Auto a = new AutoSt();//Al puntero Auto (AutoSt*) 'a' le asigno un nuevo AutoSt (el valor de un nuevo AutoSt)

    //PARA EVITAR REFERENCIAR BASURA SETEO A NULL. COPILOTO Y PILOTO YA TIENEN PUNTEROS ASIGNADOS PARA APUNTAN
    //A CAULQUIER CELDA, POR ESO SE SETEA EN NULL
    a->copiloto = NULL;
    a->piloto = NULL;

    return a;
}

void subirPiloto(Auto& a, Persona p){
    a->piloto = p;//Al valor del puntero "a" le asigno el puntero p.
}

void subirCopiloto(Auto& a, Persona p){
    a->copiloto = p;
}

void bajarPiloto(Auto& a){
    a->piloto = NULL;
    //muere(a->piloto);
    //delete a->piloto;//libero memoria.
    //a->piloto = NULL;//actualizo el puntero para que apunte a null.
}

void bajarCopiloto(Auto& a){
    a->copiloto = NULL;
    //muere(a->copiloto);
    //delete a->copiloto;
    //a->copiloto = NULL;
}

void chocaElAutoYExplotaTodo(Auto& a){
    muere(a->piloto);
    muere(a->copiloto);
    delete a;
    a = NULL;
}
