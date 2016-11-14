#include "Stack.h"

int main() {

    Stack s = emptyS();
    cout << "Stack vacio: " << endl;
    printStack(s);

    cout << endl << "¿Es vacio?: " << isEmptyS(s) << endl;

    cout << endl << "Agrego 1,2,3,4,5 al stack vacio: " << endl;
    push(1,s);push(2,s);
    push(3,s);push(4,s);
    push(5,s);
    printStack(s);

    cout << endl << "El primer elemento a sacar del stack es: " << top(s) << endl;


    cout << endl << "Saco el 5 del stack: " << endl;
    pop(s);
    printStack(s);

    cout << endl << "El size del stack es: " << sizeS(s) << endl;

    cout << endl << "Estos son los punteros del stack antes del destroy:" << endl;
    printPointersStack(s);

    destroyS(s);

//  No esta bien demostrado adonde apuntan los viejos punteros del stack.
    cout << endl << "Estos son los punteros del stack despues del destroy:" << endl;
    printPointersStack(s);

return 0;
}
