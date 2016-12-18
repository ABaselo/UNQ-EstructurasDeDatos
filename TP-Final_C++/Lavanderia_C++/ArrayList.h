#include <iostream>

using namespace std;

#define ELEM_TYPE string

struct ArrayListHeader;

typedef ArrayListHeader* ArrayList;

/** INTERFAZ BASICA **/

// Crea un ArrayList
ArrayList crearArrayList(); // O(1)

// Crea un ArrayList usando con una capacidad inicial de memoria
ArrayList crearArrayListDe(int initialCapacity); // O(1)

// Devuelve la cantidad de elementos guardados en el ArrayList
int length(ArrayList xs); // O(1)

// Precondicion: i < length(xs)
ELEM_TYPE getAt(ArrayList xs, int i); // O(1)

// Precondicion: i < length(xs)
void setAt(ArrayList& xs, int i, ELEM_TYPE x); // O(1)

// Agrega "x" al final de "xs"
void add(ArrayList& xs,  ELEM_TYPE x); // O(1) amortizado

// Borra el último elemento de "xs" y lo devuelve
// Prec.: length(xs) > 0
ELEM_TYPE remove(ArrayList& xs); // O(1)

void destroyArrayList(ArrayList& xs); // O(1)

void imprimirArrayList(ArrayList xs); // O(n)

/** INTERFAZ EXTENDIDA 1 **/

// Dice si el array list posee elementos
bool isEmpty(ArrayList xs);

// Devuelve el primer indice en el que
// encuentra un elemento igual a "x"
// Obs.: Si no lo encuentra devuelve -1
int indexOf(ArrayList xs, ELEM_TYPE x); // O(n)

// Agrega al final de "xs", todos los elementos de "ys"
void addAll(ArrayList& xs, ArrayList ys); // O(n)

// Crea una copia de todo el array
ArrayList copiar(ArrayList xs);

/** INTERFAZ EXTENDIDA 2 **/

// Agregar un elemento en la posición indicada,
// corriendo el resto de los elementos siguientes
// en una posición
void addAt(ArrayList& xs, int i, ELEM_TYPE x); // O(n)

// Borra un elemento en la posición indicada,
// corriendo el resto de los elementos siguientes
// a una posición anterior
void removeAt(ArrayList& xs, int i); // O(n)

// Devuelve una copia de la sublista desde fromIndex hasta toIndex
// Prec.: los indices se encuentran dentro del ArrayList, y fromIndex > toIndex
ArrayList sublist(ArrayList xs, int fromIndex, int toIndex); // O(n)
