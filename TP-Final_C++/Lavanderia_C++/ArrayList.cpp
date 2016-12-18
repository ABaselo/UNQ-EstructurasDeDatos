#include "ArrayList.h"

struct ArrayListHeader
{
    ELEM_TYPE* elems;
    int lastIndex;
    int maxSize;
};

/* Inv. Rep.:
   + el array 'elems' tiene tamanio 'maxSize'
   + lastIndex >= 0 y lastIndex < maxSize (menor estricto)
*/

/** INTERFAZ BASICA **/

// Crea un ArrayList
ArrayList crearArrayList() // O(1)
{
    return crearArrayListDe(16);
}

// Crea un ArrayList usando con una capacidad inicial de memoria
ArrayList crearArrayListDe(int initialCapacity) // O(1)
{
    ArrayList xs = new ArrayListHeader;
    xs->elems = new ELEM_TYPE[initialCapacity];
    xs->maxSize = initialCapacity;
    xs->lastIndex = 0;
    return xs;
}

// Devuelve la cantidad de elementos guardados en el ArrayList
int length(ArrayList xs) // O(1)
{
    return xs->lastIndex;
}

// Agranda al doble el tamanio del array
// Prec.: xs->lastIndex == xs->maxSize
void agrandar(ArrayList& xs)
{
    xs->maxSize       = xs->maxSize * 2;
    ELEM_TYPE* nuevoArray   = new ELEM_TYPE[xs->maxSize]; // creo un array nuevo

    // paso los elementos del array viejo al nuevo
    for(int i = 0; i < xs->lastIndex; i++)
    {
        nuevoArray[i] = xs->elems[i];
    }

    delete[] xs->elems; // borro el array viejo
    xs->elems   = nuevoArray; // asigno el array nuevo
}

// Agrega "x" al final de "xs"
void add(ArrayList& xs,  ELEM_TYPE x) // O(1) amortizado
{
    xs->elems[xs->lastIndex] = x;
    xs->lastIndex++;

    if(xs->lastIndex == xs->maxSize)
    {
        agrandar(xs); // O(n) pero se hace cada vez con menos frecuencia
    }
}

// Borra el último elemento de "xs" y lo devuelve
// Prec.: length(xs) > 0
ELEM_TYPE remove(ArrayList& xs) // O(1)
{
    xs->lastIndex--;
}

// Precondicion: i < length(xs)
ELEM_TYPE getAt(ArrayList xs, int i) // O(1)
{
    return xs->elems[i];
}

// Precondicion: i < length(xs)
void setAt(ArrayList& xs, int i, ELEM_TYPE x) // O(1)
{
    xs->elems[i] = x;
}

void destroyArrayList(ArrayList& xs) // O(1)
{
    delete[] xs->elems; // borro el array
    delete xs;          // borro el header
    xs = NULL;
}

void imprimirArrayList(ArrayList xs) // O(n)
{
    int i = 0;
    cout << "maxSize: " << xs->maxSize << ", ";
    cout << "length: " << xs->lastIndex << ", ";
    cout << "[" << endl;
    while(i < xs->lastIndex)
    {
        cout << "  " << i << ": " << xs->elems[i] << endl;
        i++;
    }
    cout << "]" << endl;
}

/** INTERFAZ EXTENDIDA 1 **/

// Dice si el array list posee elementos
bool isEmpty(ArrayList xs)
{
    return length(xs) == 0;
}

// Devuelve el primer indice en el que
// encuentra un elemento igual a "x"
// Obs.: Si no lo encuentra devuelve -1
int indexOf(ArrayList xs, ELEM_TYPE x) // O(n)
{
    for(int i = 0; i < length(xs); i++)
    {
        if(getAt(xs, i) == x)
        {
            return i;
        }
    }
    return -1;
}

// Agrega al final de "xs", todos los elementos de "ys"
void addAll(ArrayList& xs, ArrayList ys) // O(n)
{
    for(int i = 0; i < length(ys); i++)
    {
        add(xs, getAt(ys, i));
    }
}

// Crea una copia de todo el array
ArrayList copiar(ArrayList xs)
{
    ArrayList nuevo = crearArrayListDe(xs->maxSize);
    for(int i = 0; i < length(xs); i++)
    {
        add(nuevo, getAt(xs, i));
    }
    return nuevo;
}

/** INTERFAZ EXTENDIDA 2 **/

// Agregar un elemento en la posición indicada,
// corriendo el resto de los elementos siguientes
// en una posición
void addAt(ArrayList& xs, int i, ELEM_TYPE x) // O(n)
{
    // corro todos los elementos una posicion
    for(int j = xs->lastIndex; j > i; j--)
    {
        xs->elems[j] = xs->elems[j-1];
    }

    // seteo "x" en la posicion "i"
    xs->elems[i] = x;

    xs->lastIndex++;

    if(xs->lastIndex == xs->maxSize)
    {
        agrandar(xs); // O(n) pero se hace cada vez con menos frecuencia
    }
}

// Borra un elemento en la posición indicada,
// corriendo el resto de los elementos siguientes
// a una posición anterior
void removeAt(ArrayList& xs, int i) // O(n)
{
    for(int j = i; j < xs->lastIndex; j++)
    {
        xs->elems[j] = xs->elems[j+1];
    }
    xs->lastIndex--;
}

// Devuelve una copia de la sublista desde fromIndex hasta toIndex
// Prec.: los indices se encuentran dentro del ArrayList, y fromIndex > toIndex
ArrayList sublist(ArrayList xs, int fromIndex, int toIndex) // O(n)
{
    ArrayList nuevo = crearArrayList();
    for(int i = fromIndex; i < toIndex+1; i++)
    {
        add(nuevo, getAt(xs, i));
    }
    return nuevo;
}
