#include "Lavadero.h"

/*
INVARIANTE DE REPRESENTACION
----------------------------
- Dado un Lavadero con un Map de clientes y un SetPlanes:
    * Un Cliente del lavadero, en todo momento debe tener asignado un Plan existente en el lavadero.
    * El plan al cual pertenece un cliente se define en base a la cantidad maxima de prendas que le fue
      asignado en algun momento mientras es socio del lavadero.
    * Un cliente no cambia de plan si regresa prendas al lavadero.
    * Si un cliente pertenece a un determinado plan, entonces dicho plan guarda el cuit del cliente. Ademmas, el cliente
      debe guardar el nombre del plan al cual pertenece.
*/

/**
Prop.: Crea un lavadero vacio.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Todas las funciones utilizadas son O(1).
Lavadero crearLavadero() {
    Lavadero l = new LavaderoSt;
    l->clientes = emptyM();
    l->planes = crearPlanes();
    return l;
}

/**
Prop.: Devuelve un cliente con cierto cuit. Si no existe el cliente con el CUIT en el lavadero se retorna NULL.
Prec.: Ninguna.
*/
//O(log n), con n = cantidad de clientes del lavadero.
//Justificacion: lookupM es O(log n).
Cliente obtenerCliente(Lavadero& lavadero, string cuit) {
    return lookupM(lavadero->clientes, cuit);
}

/**
Prop.: Incorpora un cliente nuevo con plan inicial. Si el cliente ya existía entre los clientes del
	   lavadero, entonces, no se realizará ningún cambio en el lavadero.
Prec.: Ninguna.
*/
//O(log n), con n = cantidad de clientes del lavadero.
//Justificacion: addM es O(log n).
void agregarCliente(Lavadero& lavadero, string cuit, string nombre) {
    addM(lavadero->clientes, crearCliente(cuit, nombre, "inicial"));    //O(n), con n=cantidad de clientes del lavadero
    agregarAPrimerPlan(lavadero->planes, cuit);                         //O(1)
}

/**
Prop.: Elimina un cliente del lavadero. Si el cliente no existe entre los clientes del
	   lavadero, entonces, no se realizará ningún cambio en el lavadero.
Prec.: Ninguna.
*/
//O(n + log n), con n = cantidad de clientes del lavadero.
//Justificacion: borrarDePlan es O(n). En peor caso, el plan donde se borra
//               tiene todos los clientes del lavadero.
void borrarCliente(Lavadero& lavadero, string cuit) {
	Cliente c = obtenerCliente(lavadero, cuit);             //O(log n)

    if(not isNothing(c))
	{
		removeM(lavadero->clientes, cuit);                  //O(log n)
		borrarDePlan(lavadero->planes, getPlan(c), cuit);   //O(n)
	}
}

/**
Prop.: Le otorga una cantidad de prendas a un cliente.
Prec.: cantidad >= 0
*/
// O(n), con n = cantidad de planes en el lavadero
//Justificacion: chequearPlan es O(n) en peor caso.
void darPrendas(Lavadero& lavadero, string cuit, int cantidad) {
    Cliente c = obtenerCliente(lavadero, cuit);
	if(not isNothing(c))
	{
		aumentarPrendas(c, cantidad);
		/// ACTUALIZA EL PLAN SI DEBE HACERLO
		string p = chequearPlan(lavadero->planes, getPlan(c), cuit, getCantidadPrendas(c));
		setPlan(c, p);
	}
}

/**
Prop.: Recibe una cantidad de prendas devueltas por un cliente.
Prec.: Ninguna.
*/
// O(log n), con n = cantidad de clientes del lavadero.
//Justificacion: obtenerCliente es O(log n)
void recibirPrendas(Lavadero& lavadero, string cuit, int cantidad) {
    Cliente c = obtenerCliente(lavadero, cuit);
	if(not isNothing(c))
		disminuirPrendas(c, cantidad);
}

/**
Prop.: Devuelve la cantidad total de clientes del lavadero.
Prec.: Ninguna.
*/
// O(n), con n = cantidad de clientes del lavadero.
//Justificacion: domM es O(n).
int cantidadTotalDeClientes(Lavadero lavadero) {
    length(domM(lavadero->clientes));
}

/**
Prop.: Devuelve el plan con mas clientes.
       Si ningun plan tiene clientes se responde con el primer plan del lavadero.
Prec.: Existe por lo menos un plan en el lavadero.
*/
// O(n), con n = cantidad de planes del lavadero.
//Justificacion: Se itera sobre todos los planes del lavadero en peor caso.
string planConMasClientes(Lavadero lavadero) {
    PlanIterator it = startIt(lavadero->planes);

    string planMaxClientes = currentIt(it);
    int cantMax = 0;
    int cantCurrentPlan;

    while(not finishedIt(it))
    {
        cantCurrentPlan = cantidadDeClientes(it->planes, currentIt(it));
        if(cantCurrentPlan > cantMax)
        {
            cantMax = cantCurrentPlan;
            planMaxClientes = currentIt(it);
        }
        nextIt(it);
    }
    destroyIt(it);

    return planMaxClientes;
}

/**
Prop.: Destruye la memoria utilizada por el lavadero.
Prec.: Ninguna.
*/
// O(m + log n), con m = cantidad de planes y con n = cantidad de clientes del lavadero.
//Justificación: destroyM es O(n) y destroyPlanes es O(m). Debido a que 'm' y 'n' son magnitudes de distinto valor,
//				 el costo de esta funcion es la suma de los ordenes de destroyM y destroyPlanes.
void destroyLavadero(Lavadero& lavadero) {
     destroyM(lavadero->clientes);      //O(n), con n = cantidad de pares key-value en el map.
     destroyPlanes(lavadero->planes);   //O(m), con m = cantidad de planes.
     delete lavadero;
     lavadero = NULL;
}

/**
Prop.: Dados un plan y un lavadero se borran a todos los clientes de ese plan en el lavadero.
Prec.: Existe el plan en el lavadero.
*/
// O(m.(n + log n) en peor caso, con n = cantidad de clientes del lavadero.
// Justificacion: Siendo n = cantidad de clientes del lavadero y m = cantidad de CUITs de clientes del plan dado,
//                por cada CUIT de cliente en 'm' se debe borrar el cliente con ese CUIT en el Map del lavadero.
void borrarClientesDePlan(string plan, Lavadero& lavadero) {
    ArrayList cs = getCuitsDeClientes(lavadero->planes, plan);

    // Borro todos los clientes de ese plan del arbol.
    while(not isEmpty(cs))                 //O(m.(n + log n))
        borrarCliente(lavadero, getAt(cs, 0));      //O(n + log n)
}

void printLavadero(Lavadero lavadero) {
    printMap(lavadero->clientes);
    printSet(lavadero->planes);
}
