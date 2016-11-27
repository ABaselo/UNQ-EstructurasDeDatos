#include "Queue.h"

void printTestLabel(string funcionATestear)
{
    int subrayado = funcionATestear.length();
    cout << endl;
    cout << funcionATestear << endl;
    for(int i=0; i<subrayado; i++)
        cout << "-";
    cout << endl;
}

int main() {

printTestLabel("Queue emptyQ();");
Queue cola = emptyQ();

printQ(cola);

printTestLabel("bool isEmptyQ(Queue q);");
cout << "¿Es vacia?: " << isEmptyQ(cola) << endl;

printTestLabel("void queue(Queue& q, ELEMENT_TYPE x);");
cout << "Agrego elementos a la cola:" << endl;
queue(cola, 1);
queue(cola, 2);
queue(cola, 3);

printQ(cola);

printTestLabel("ELEMENT_TYPE firstQ(Queue q);");
cout << "Este es el primer elemento de la cola: " << firstQ(cola) << endl << endl;

printTestLabel("void dequeue(Queue& q);");
cout << "Saco el 1" << endl;
dequeue(cola);
printQ(cola);
cout << "Saco el 2" << endl;
dequeue(cola);
printQ(cola);
cout << "Saco el 3 y queda la cola vacia" << endl;
dequeue(cola);
printQ(cola);

printTestLabel("void destroyQ(Queue& q);");
cout << "Primero creo un queue con tres elementos:";
queue(cola, 1);
queue(cola, 2);
queue(cola, 3);

printQ(cola);

cout << "Ahora la destruyo:" << endl;
destroyQ(cola);

printQ(cola);

return 0;
}
