#include "SetPlanes.h"
#define INT_MAX  65000

/*
INVARIANTE DE REPRESENTACION
----------------------------
- Dado un SetPlanes con un string nombre y un ArrayList de cuitsDeClientes:
    * No hay planes repetidos.
    * Cada Plan tiene un unico siguiente Plan, excepto por el Plan "full", el cual no tiene siguiente plan.
    * Un Plan no tiene CUITs repetidos.
    * Si un CUIT pertenece a un Plan, entonces, este CUIT no pertenece a ningun otro plan.
*/

/***
    CONSTANTES SOBRE PLANES
***/

int cantidadDePlanes() {
    return 5;
}

ArrayList nombresDePlanes() {
    ArrayList xs = crearArrayList();
    add(xs, "inicial");
    add(xs, "basico");
    add(xs, "intermedio");
    add(xs, "avanzado");
    add(xs, "full");
    return xs;
}

int planToIndex(string plan) {
    if(plan == "inicial") {
        return 0;
    }
    if(plan == "basico") {
        return 1;
    }
    if(plan == "intermedio") {
        return 2;
    }
    if(plan == "avanzado") {
        return 3;
    }
    if(plan == "full") {
        return 4;
    }
}

string indexToPlan(int index) {
    if(index == 0) {
        return "inicial";
    }
    if(index == 1) {
        return "basico";
    }
    if(index == 2) {
        return "intermedio";
    }
    if(index == 3) {
        return "avanzado";
    }
    if(index == 4) {
        return "full";
    }
}

int cantidadDePlan(string plan) {
    if(plan == "inicial") {
        return 0;
    }
    if(plan == "basico") {
        return 10;
    }
    if(plan == "intermedio") {
        return 50;
    }
    if(plan == "avanzado") {
        return 100;
    }
    if(plan == "full") {
        return INT_MAX;
    }
}

/***
    INTERFAZ DE PLANES
***/

/// AUXILIAR
Plan nuevoPlan(string nombre) {
    Plan p = new PlanSt;
    p->nombre = nombre;
    p->cuitsClientes = crearArrayList();
    return p;
}

// Prop.: crea un set con todos los planes
// O(1)
SetPlanes crearPlanes() {
    ArrayList nombres = nombresDePlanes();
    Plan* planes = new Plan[cantidadDePlanes()];
    for(int i = 0; i < cantidadDePlanes(); i++) {
        string nombreActual = getAt(nombres, i);
        int indiceDeNombre  = planToIndex(nombreActual);
        planes[indiceDeNombre] = nuevoPlan(nombreActual);
    }
    destroyArrayList(nombres);
    return planes;
}

/// AUXILIAR
Plan planConNombre(SetPlanes ps, string plan) {
    return ps[planToIndex(plan)];
}

/**
Prop.: Agrega un cliente a un plan.
Prec.: 'plan' pertenece a 'ps'.
*/
// O(1)
//Justificacion: Todas las funciones utilizadas son O(1).
void agregarAPlan(SetPlanes& ps, string plan, string cuit) {
    Plan p = planConNombre(ps, plan);   //O(1)
    add(p->cuitsClientes, cuit);        //O(1)  amortizado
}

/**
Prop.: Agrega un cliente al plan inicial.
Prec.: Plan "inicial" pertenece al 'ps' dado.
*/
// O(1)
//Justificacion: agregarAPlan es O(1).
void agregarAPrimerPlan(SetPlanes& ps, string cuit) {
    return agregarAPlan(ps, "inicial", cuit);   //O(1)
}

/**
Prop.: Borra un cliente de un plan.
Prec.: 'plan' pertenece a 'SetPlanes'.
*/
// O(n), con n = cantidad de clientes en el plan.
//Justificacion: Debido a que removeAt en peor caso es O(n).
void borrarDePlan(SetPlanes& ps, string plan, string cuit) {
    Plan p = planConNombre(ps, plan);
    int elemIndex = indexOf(p->cuitsClientes, cuit);
    removeAt(p->cuitsClientes, elemIndex);              //O(n)
}

/**
Prop.: Devuelve la cantidad de clientes de un plan.
Prec.: 'plan' pertenece a 'SetPlanes'.
*/
// O(1)
//Justificacion: Todas las funciones utilizadas son O(1).
int cantidadDeClientes(SetPlanes ps, string plan) {
    Plan p = planConNombre(ps, plan);
    return length(p->cuitsClientes);        //O(1)
}

/// AUXILIAR
//O(1)
bool debeAumentarPlan(string planActual, int cantidadDeCliente) {
    return cantidadDePlan(planActual) < cantidadDeCliente;
}

/// AUXILIAR
//O(1)
string siguientePlan(string planActual) {
    return indexToPlan(planToIndex(planActual) + 1);
}

/// AUXILIAR
//O(n), con n = cantidad de planes.
//Justificacion: borrarDePlan es O(n)
void pasarASiguientePlan(SetPlanes& ps, string plan, string cuit) {
    borrarDePlan(ps, plan, cuit);                      //O(n) n=cantidad de planes
    agregarAPlan(ps, siguientePlan(plan), cuit);       //O(1)
}

/**
Prop.: Pasa un cliente al siguiente plan si corresponde y devuelve el plan en el que debería estar.
Prec.: cantidadDePrendas < INT_MAX, cantidadDePrendas >= 0, 'plan' pertenece a 'ps'
*/
// O(n), con n = cantidad de planes.
//Justificacion: pasarASiguientePlan es O(n)
string chequearPlan(SetPlanes& ps, string plan, string cuit, int cantidadDePrendas) {
    string nuevoPlan = plan;

    while(debeAumentarPlan(nuevoPlan, cantidadDePrendas))
    {
        pasarASiguientePlan(ps, nuevoPlan, cuit);
        nuevoPlan = siguientePlan(nuevoPlan);
    }

    return nuevoPlan;
}

/// AUXILIAR
//O(1)
void destroyPlan(Plan& p) {
    destroyArrayList(p->cuitsClientes); //O(1)
    delete p;
    p = NULL;
}

/**
Prop.: Destruye la memoria del set de planes.
Prec.: Ninguna.
*/
// O(n), con n = cantidad de planes.
//Justificacion: Se debe recorrer todos los planes para destruirlos.
void destroyPlanes(SetPlanes& ps) {
    for(int i=0; i<cantidadDePlanes(); i++)
        destroyPlan(ps[i]);
    ps = NULL;
}

/***
    ITERADOR DE PLANES
***/

/**
Prop.: Crea un nuevo iterador de SetPlanes, el cual apunta al primer Plan de SetPlanes.
Prec.: ps != NULL.
*/
//O(1)
//Justificacion: Crea una nueva estructura de iterador de planes y lo retorna.
PlanIterator startIt(SetPlanes ps) {
    PlanIterator it = new PlanesIteratorSt;
    it->indiceActual = 0;
    it->planes = ps;

    return it;
}

/**
Prop.: Retorna el Plan de SetPlanes que es actualmente apuntado por el iterador dado.
Prec.: Solo se debe llamar a esta funcion si: it->indiceActual < lenght(it->planes)
*/
//O(1)
//Justificacion: indexToPlan es O(1).
string currentIt(PlanIterator it) {
    return indexToPlan(it->indiceActual);
}

/**
Prop.: El iterador apuntara al siguiente plan de it->planes.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Actualiza un valor de la estructura del iterador.
void nextIt(PlanIterator& it) {
    it->indiceActual++;
}

/**
Prop.: Se responde si el iterador termino la iteracion, eso es cuando el iterador ya no apunta a ningun plan.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Se evalua una operacion booleanda y se retorna el resultado.
bool finishedIt(PlanIterator it) {
    return it->indiceActual == cantidadDePlanes();
}

/**
Prop.: Destruye el iterador dado.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Se libera la memoria utilizada por el iterador.
void destroyIt(PlanIterator& it) {
    delete it;
    it = NULL;
}

/**
Prop.: Retorna una lista de CUITs de un determinado plan.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Retorna un valor de la estructura de un determinado plan.
ArrayList getCuitsDeClientes(SetPlanes ps, string plan) {
    return planConNombre(ps, plan)->cuitsClientes;
}

/**
Prop.: Se borran todos los CUITs de un determinado plan.
Prec.: Ninguna.
*/
// O(1)
// Justificacion: Se destruye el arraylist de cuit de clientes y se crea uno nuevo.
//                Todas las operaciones para realizar esta tarea son de costo O(1).
void borrarClientesDePlan(SetPlanes ps, string plan) {
    Plan p = planConNombre(ps, plan);
    destroyArrayList(p->cuitsClientes);     //O(1)
    p->cuitsClientes = crearArrayList();    //O(1)
}

/***
    IMPRESION DE PLANES
***/

void printPlan(Plan p) {
    cout << "---- Plan: " << p->nombre << endl;
    cout << "---- Clientes: " << endl;
    imprimirArrayList(p->cuitsClientes);
}

void printSet(SetPlanes ps) {

    cout << "-- Planes: " << endl;

    for(int i = 0; i < cantidadDePlanes(); i++) {
        printPlan(ps[i]);
    }

}
