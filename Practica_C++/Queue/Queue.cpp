#include "Queue.h"

/**
INVARIANTE DE REPRESENTACION:
    Dado una Queue con punteros al primer y ultimo elemento de la cola:
        * La cola vacia es NULL.
        * Toda insercion solo se realiza al final de la cola.
        * Toda extraccion se realiza al primer elemento de la cola.
        * firstIn de la cola apunta al primer elemento ingresado.
        * lastIn de la cola apunta al ultimo elemento ingresado.
*/


/*
Prop.: Retorna una cola vacia.
Prec.: Ninguna.
*/
Queue emptyQ()
{
    return NULL;
}

/*
Prop.: Retorna true si la cola esta vacia.
Prec.: Ninguna.
*/
bool isEmptyQ(Queue q)
{
    return q == NULL;
}

/*
Prop.: Dados una cola y un elemento, se coloca el elemento en la cola.
Prec.: Ninguna.
*/
void queue(Queue& q, ELEMENT_TYPE x)
{
    List nodeQ = new NodeQST;
    nodeQ->value = x;
    nodeQ->prev = NULL; //Al ser el ultimo de la cola no hay elemento anterior.

    if(isEmptyQ(q))
    {
        q = new QueueST;
        q->firstIn = nodeQ;
        q->lastIn = nodeQ;

        nodeQ->next = NULL;
    }
    else
    {
        nodeQ->next = q->lastIn;
        q->lastIn->prev = nodeQ;

        q->lastIn = nodeQ;      //ahora para la cola nodeQ es el ultimo elemento ingresado.
    }
}

/*
Prop.: Se retorna el primer elemento de la cola.
Prec.: Parcial en cola vacia.
*/
ELEMENT_TYPE firstQ(Queue q)
{
    return q->firstIn->value;
}

/*
Prop.: Elimina el primer elemento de la cola.
       Si la queue tiene un unico elemento, entonces dequeue retorna una emptyQ.
Prec.: Parcial en cola vacia.
*/
void dequeue(Queue& q)
{
    if(q->firstIn == q->lastIn)
    {//La cola tiene un solo elemento.
        delete q->firstIn;
        delete q;
        q = NULL;
    }
    else
    {
        List prev_elem = q->firstIn->prev;  //Guardo puntero al elemento anterior para no perderlo

        delete q->firstIn;
        q->firstIn = prev_elem;

        prev_elem->next = NULL;
    }
}

/*
Prop.: Destruye toda la queue.
Prec.: Ninguna.
*/
void destroyQ(Queue& q)
{
    while(not isEmptyQ(q))
    {
        dequeue(q);
    }
}


//Imprime la queue en consola
void printQ(Queue q)
{
    if(not isEmptyQ(q))
    {
        cout << endl << "FIRST-IN: " << q->firstIn << " LAST-IN: " << q->lastIn << endl;
        List currentNode = q->lastIn;
        cout << "ELEM   ACTUAL  SIGUIENTE   ANTERIOR" << endl;
        while(currentNode != NULL)
        {
            cout << currentNode->value << " || " << currentNode << " || " << currentNode->next << " || " << currentNode->prev << endl;
            currentNode = currentNode->next;
        }
    }
    else
    {
        cout << "La queue esta vacia: " << q << endl;
    }
    cout << endl;
}
