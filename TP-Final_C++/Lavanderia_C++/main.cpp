#include <iostream>
#include "Lavadero.h"

using namespace std;

// Imprime por pantalla el titulo dado como parametro en formato encabezado.
void titleHeader(string title)
{
    int l = title.length() + 4;
    cout << endl;
    for(int i=0; i<l; i++)
        cout << "*";

    cout << endl << "* " << title << " *" << endl;

    for(int i=0; i<l; i++)
        cout << "*";
    cout << endl;
}

// Imprime por pantalla el titulo dado como parametro subrayado.
void title(string title)
{
    cout << endl << title << endl;
    for(int i=0; i<title.length(); i++)
        cout << "-";
    cout << endl;
}

//Si la expresion booleana dada es true imprime "ok...", caso contrario "fallo..."
void assert(bool is_true)
{
    if(is_true)
        cout << endl << "> OK..." << endl << endl;
    else
        cout << endl << "X FALLO..." << endl << endl;
}



/** ----------------------------- **/
/** --------- TESTS MAP --------- **/
/** ----------------------------- **/

bool testMap_buscarAgregarYEliminarCliente(){
	title("Test: agregar un cliente, buscar por cuit y borrar por cuit en Map");

	Map m = emptyM();
	Cliente c1 = crearCliente("111", "Cliente test 1", "inicial");
	Cliente c2 = crearCliente("222", "Cliente test 2", "inicial");
	Cliente c3 = crearCliente("333", "Cliente test 3", "inicial");
	Cliente c4 = crearCliente("444", "Cliente test 4", "inicial");
	Cliente c5 = crearCliente("555", "Cliente test 5", "inicial");

	Cliente clienteBuscado;
	clienteBuscado = lookupM(m, "333");

	cout << "* Busco el cliente con el cuit \"333\" en un map vacio y no lo encuentro: ";
	assert(isNothing(lookupM(m, "333")) );

	addM(m, c1);  addM(m, c2);  addM(m, c3);  addM(m, c4);  addM(m, c5);

	clienteBuscado = lookupM(m, "333");

	cout << "* Agrego el cliente con el cuit \"333\", lo busco en el map y lo encuentro: ";
	assert(not isNothing(lookupM(m, "333")) );

	removeM(m, "333");

	clienteBuscado = lookupM(m, "333");

    cout << "* Remuevo el cliente con el cuit \"333\" del map, lo busco y no lo encuentro: ";
	assert(isNothing(lookupM(m, "333")) );

	destroyM(m);
}

bool testMap_dominio() {
	title("Test: obtener el dominio de Map");

	Map m = emptyM();
	ArrayList dom;
	Cliente c1 = crearCliente("111", "Cliente test1", "inicial");
	Cliente c2 = crearCliente("222", "Cliente test2", "inicial");
	Cliente c3 = crearCliente("333", "Cliente test3", "inicial");
	Cliente c4 = crearCliente("444", "Cliente test4", "inicial");
	Cliente c5 = crearCliente("555", "Cliente test5", "inicial");

	dom = domM(m);

    cout << "* Creo un map vacio y su dominio es igual a 0: ";
	assert(length(dom) == 0);

	addM(m, c1);  addM(m, c2);  addM(m, c3);  addM(m, c4);  addM(m, c5);

	dom = domM(m);

    cout << "* Agrego 5 clientes en el map y ahora el dominio tiene 5 elementos: ";
	assert(length(dom) == 5);

    destroyM(m);
    destroyArrayList(dom);
}

bool testMap_destroy()
{
	title("Test: Destruir map");

	Map m = emptyM();
	Cliente c1 = crearCliente("111", "Cliente test1", "inicial");
	Cliente c2 = crearCliente("222", "Cliente test2", "inicial");
	Cliente c3 = crearCliente("333", "Cliente test3", "inicial");
	Cliente c4 = crearCliente("444", "Cliente test4", "inicial");
	Cliente c5 = crearCliente("555", "Cliente test5", "inicial");

	addM(m, c1);  addM(m, c2);  addM(m, c3);  addM(m, c4);  addM(m, c5);

	destroyM(m);

    cout << "* Creo un map con 5 clientes y destruyo el map: ";
	assert(m == NULL);
}

void testMap()
{
    titleHeader("Tests Map");

	testMap_buscarAgregarYEliminarCliente();
	testMap_dominio();
	testMap_destroy();
}



/** --------------------------------- **/
/** --------- TESTS CLIENTE --------- **/
/** --------------------------------- **/

bool testCliente_aumentarYDisminuirPrendas()
{
    title("Test: Aumento y disminuyo las prendas de un cliente");

    Cliente c = crearCliente("111", "Cliente Test", "un plan");

    cout << "* Creo un cliente sin prendas: ";
    assert(getCantidadPrendas(c) == 0);

    aumentarPrendas(c, 10);

    cout << "* Aumento sus prendas: ";
    assert(getCantidadPrendas(c) == 10);

    disminuirPrendas(c, 5);

    cout << "* Disminuyo sus prendas: ";
    assert(getCantidadPrendas(c) == 5);

    destroyCliente(c);
}

bool testCliente_destruyoUnCliente()
{
    title("Test: Destruyo un cliente");

    Cliente c = crearCliente("111", "Cliente Test", "un plan");

    destroyCliente(c);

    cout << "* Destruyo un cliente y este ya no existe: ";
    assert(c == NULL);

}

void testCliente()
{
    titleHeader("Tests Cliente");

    testCliente_aumentarYDisminuirPrendas();
    testCliente_destruyoUnCliente();
}



/** ----------------------------------- **/
/** --------- TESTS SETPLANES --------- **/
/** ----------------------------------- **/

bool testSetPlanes_agregoUnCuitAUnPlan()
{
    title("Test: Agrego el CUIT de un cliente en un Plan");
    SetPlanes ps = crearPlanes();

    cout << "* Creo un SetPlanes con plan \"full\" sin CUITs: ";
    assert(cantidadDeClientes(ps, "full") == 0);

    agregarAPlan(ps, "full", "111");

    cout << "* Agrego un CUIT al plan \"full\" y ahora tiene un CUIT: ";
    assert(cantidadDeClientes(ps, "full") == 1);

    destroyPlanes(ps);
}

bool testSetPlanes_agregoUnCuitAlPrimerPlan()
{
    title("Test: Agrego el CUIT de un cliente al primer Plan");
    SetPlanes ps = crearPlanes();

    cout << "* Creo un SetPlanes con plan \"inicial\" sin CUITs: ";
    assert(cantidadDeClientes(ps, "inicial") == 0);

    agregarAPrimerPlan(ps, "111");

    cout << "* Agrego un CUIT al plan \"inicial\" y ahora tiene un CUIT: ";
    assert(cantidadDeClientes(ps, "inicial") == 1);

    destroyPlanes(ps);
}

bool testSetPlanes_remuevoUnCuitAUnPlanQueTieneGuardadoElCuit()
{
    title("Test: Remuevo un CUIT de un Plan");
    SetPlanes ps = crearPlanes();

    agregarAPrimerPlan(ps, "111");
    agregarAPrimerPlan(ps, "222");
    agregarAPrimerPlan(ps, "333");

    cout << "* Creo un SetPlanes con 3 CUIT en el plan \"inicial\": ";
    assert(cantidadDeClientes(ps, "inicial") == 3);

    borrarDePlan(ps, "inicial", "222");

    cout << "* Remuevo el CUIT \"222\" agregado al plan \"inicial\": ";
    assert(cantidadDeClientes(ps, "inicial") == 2);

    destroyPlanes(ps);
}

bool testSetPlanes_chequearPlanCorrespondienteSegunSuCantidadDePrendas()
{
    title("Test: Paso un cliente (CUIT) al plan correspondiente");

    SetPlanes ps = crearPlanes();

    agregarAPrimerPlan(ps, "111");

    cout << "* Creo un SetPlanes con el CUIT \"111\" en el plan \"inicial\": ";
    assert(cantidadDeClientes(ps, "inicial") == 1);

    chequearPlan(ps, "inicial", "111", 1);

    cout << "* Paso el cliente con el CUIT \"111\" al siguiente plan \"basico\": ";
    assert( cantidadDeClientes(ps, "inicial") == 0 &&
            cantidadDeClientes(ps, "basico")  == 1);

    chequearPlan(ps, "basico", "111", 1000);

    cout << "* Paso el cliente con el CUIT \"111\" al ultimo plan \"full\": ";
    assert( cantidadDeClientes(ps, "basico") == 0 &&
            cantidadDeClientes(ps, "full")  == 1);

    destroyPlanes(ps);
}

bool testSetPlanes_destruyoSetDePlanes()
{
    title("Test: Destruyo un set de planes");

    SetPlanes ps = crearPlanes();

    destroyPlanes(ps);

    cout << "* Creo y luego destruyo un SetPlanes: ";
    assert(ps == NULL);
}

bool testSetPlanes_iterador()
{
    title("Test: Iterar un set de planes");

    SetPlanes ps = crearPlanes();
    bool test_ok = true;
    PlanIterator it = startIt(ps);

    test_ok &= currentIt(it) == "inicial" && not finishedIt(it);
    nextIt(it);
    test_ok &= currentIt(it) == "basico" && not finishedIt(it);
    nextIt(it);
    test_ok &= currentIt(it) == "intermedio" && not finishedIt(it);
    nextIt(it);
    test_ok &= currentIt(it) == "avanzado" && not finishedIt(it);
    nextIt(it);
    test_ok &= currentIt(it) == "full" && not finishedIt(it);
    nextIt(it);
    test_ok &= finishedIt(it);

    cout << "* Itero sobre un SetPlanes: ";
    assert(test_ok);

    destroyIt(it);

    cout << "* Destruyo el iterador: ";
    assert(it == NULL);

    destroyPlanes(ps);
}

bool testSetPlanes_borrarClientesDePlan()
{
    title("Test: Borro todos los CUITs de un Plan");
    SetPlanes ps = crearPlanes();

    agregarAPrimerPlan(ps, "111");
    agregarAPrimerPlan(ps, "222");
    agregarAPrimerPlan(ps, "333");

    cout << "* Creo un SetPlanes con 3 CUIT en el plan \"inicial\": ";
    assert(length(getCuitsDeClientes(ps, "inicial")) == 3);

    borrarClientesDePlan(ps, "inicial");

    cout << "* Borro los CUITs del plan \"inicial\": ";
    assert(length(getCuitsDeClientes(ps, "inicial")) == 0);
}

void testSetPlanes()
{
    titleHeader("Tests SetPlanes");

    testSetPlanes_agregoUnCuitAUnPlan();
    testSetPlanes_agregoUnCuitAlPrimerPlan();
    testSetPlanes_remuevoUnCuitAUnPlanQueTieneGuardadoElCuit();
    testSetPlanes_chequearPlanCorrespondienteSegunSuCantidadDePrendas();
    testSetPlanes_destruyoSetDePlanes();
    testSetPlanes_iterador();
    testSetPlanes_borrarClientesDePlan();
}



/** ---------------------------------- **/
/** --------- TESTS LAVADERO --------- **/
/** ---------------------------------- **/

bool testLavadero_obtenerCliente()
{
    title("Test: Obtengo un cliente de un lavadero");

    Lavadero l = crearLavadero();

    agregarCliente(l, "111", "Cliente 1");
    agregarCliente(l, "222", "Cliente 2");
    agregarCliente(l, "333", "Cliente 3");
    agregarCliente(l, "444", "Cliente 4");
    agregarCliente(l, "555", "Cliente 5");

    Cliente clienteObtenido = obtenerCliente(l, "111");

    cout << "* Recupero un cliente del lavadero y compruebo que se haya recuperado\n  correctamente: ";
    assert( getCuit(clienteObtenido) == "111" &&
            getCantidadPrendas(clienteObtenido) == 0 &&
            getNombre(clienteObtenido) == "Cliente 1" &&
            cantidadDeClientes(l->planes, "inicial") == 5 );

    destroyLavadero(l);
}

bool testLavadero_borrarCliente()
{
    title("Test: Borro un cliente de un lavadero");

    Lavadero l = crearLavadero();


    agregarCliente(l, "111", "Cliente 1");
    agregarCliente(l, "222", "Cliente 2");
    agregarCliente(l, "333", "Cliente 3");
    agregarCliente(l, "444", "Cliente 4");
    agregarCliente(l, "555", "Cliente 5");

    borrarCliente(l, "222");

    cout << "* Borro un cliente del lavadero y compruebo que se haya borrado\n  correctamente: ";
    assert( obtenerCliente(l, "222") == NULL );

    destroyLavadero(l);
}

bool testLavadero_darYRecibirPrendas()
{
    title("Test: Dar y recibir prendas de un cliente de un lavadero");

    Lavadero l = crearLavadero();
    agregarCliente(l, "111", "Cliente 1");
    Cliente c = obtenerCliente(l, "111");

    cout << "* Cliente del lavadero sin prendas y con plan inicial: ";
    assert( getCantidadPrendas(c) == 0 &&
            getPlan(c) == "inicial" &&
            cantidadDeClientes(l->planes, "inicial") == 1 &&
            cantidadDeClientes(l->planes, "intermedio") == 0);

    darPrendas(l, "111", 11);

    cout << "* El lavadero le da 10 prendas al cliente y sube de plan \n(el nuevo plan del cliente se refleja en el cliente y en el set de planes del lavadero): ";
    assert( getCantidadPrendas(c) == 11 &&
            getPlan(c) == "intermedio" &&
            cantidadDeClientes(l->planes, "inicial") == 0 &&
            cantidadDeClientes(l->planes, "intermedio") == 1);


    recibirPrendas(l, "111", 5);

    cout << "* El lavadero recibe 5 prendas del cliente y el cliente no cambia su plan: ";
    assert( getCantidadPrendas(c) == 6 &&
            getPlan(c) == "intermedio" &&
            cantidadDeClientes(l->planes, "inicial") == 0 &&
            cantidadDeClientes(l->planes, "intermedio") == 1);

    destroyLavadero(l);
}

bool testLavadero_cantidadDeClientesDelLavadero()
{
    title("Test: Cantidad de clientes de un lavadero");

    Lavadero l = crearLavadero();

    agregarCliente(l, "111", "Cliente 1");
    agregarCliente(l, "222", "Cliente 2");
    agregarCliente(l, "333", "Cliente 3");
    agregarCliente(l, "444", "Cliente 4");
    agregarCliente(l, "555", "Cliente 5");

    cout << "* La cantidad de clientes del lavadero es 5: ";
    assert( cantidadTotalDeClientes(l) == 5 );

    destroyLavadero(l);
}

bool testLavadero_planConMasClientesDelLavadero()
{
    title("Test: Plan con mas clientes de un lavadero");

    Lavadero l = crearLavadero();

    agregarCliente(l, "111", "Cliente 1");
    agregarCliente(l, "222", "Cliente 2");
    darPrendas(l, "222", 9);
    agregarCliente(l, "333", "Cliente 3");
    darPrendas(l, "333", 50);
    agregarCliente(l, "444", "Cliente 4");
    darPrendas(l, "444", 50);
    agregarCliente(l, "555", "Cliente 5");
    darPrendas(l, "555", 50);

    cout << "* El plan con mas clientes del lavadero es el \"intermedio\": ";
    assert( planConMasClientes(l) == "intermedio" );

    destroyLavadero(l);
}

bool testLavadero_borrarClientesDePlan()
{
    title("Test: Borro todos los clientes de un determinado plan en el lavadero");

    Lavadero l = crearLavadero();

    //Clientes en el plan "inicial"
    agregarCliente(l, "111", "Cliente 1");
    agregarCliente(l, "222", "Cliente 2");
    agregarCliente(l, "333", "Cliente 3");
    agregarCliente(l, "444", "Cliente 4");

    cout << "* Cantidad de clientes en el plan inicial: ";
    assert(cantidadDeClientes(l->planes, "inicial") == 4);

    borrarClientesDePlan("inicial", l);

    cout << "* Agrego clientes al plan \"inicial\" y borro los clientes de ese plan: ";
    assert( cantidadDeClientes(l->planes, "inicial") == 0 &&
            obtenerCliente(l, "111") == NULL &&
            obtenerCliente(l, "222") == NULL &&
            obtenerCliente(l, "333") == NULL &&
            obtenerCliente(l, "444") == NULL );
}

void testLavadero()
{
    titleHeader("Tests Lavadero");

    testLavadero_obtenerCliente();
    testLavadero_borrarCliente();
    testLavadero_darYRecibirPrendas();
    testLavadero_cantidadDeClientesDelLavadero();
    testLavadero_planConMasClientesDelLavadero();
    testLavadero_borrarClientesDePlan();
}



int main()
{
    testMap();
    testCliente();
    testSetPlanes();
    testLavadero();

    return 0;
}
