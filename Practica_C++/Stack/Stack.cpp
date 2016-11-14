#include "Stack.h"

Stack emptyS() {
    Stack s = new StackST;
    s->node = NULL;
    s->sizeS = 0;
    return s;
}

bool isEmptyS(Stack s) {
    return s->sizeS == 0;
}

void push(int x, Stack& s) {
    SNodeST* newNode = new SNodeST;
    newNode->value = x;
    newNode->next = s->node;
    s->sizeS++;
    s->node = newNode;
}

int top(Stack s) {
    return s->node->value;
}

void pop(Stack& s) {
    SNodeST* tmp = s->node;
    s->node = tmp->next;
    s->sizeS--;
    delete tmp;
    tmp = NULL;

}

int sizeS(Stack s) {
    return s->sizeS;
}

void destroyS(Stack& s) {
    while(s->node != NULL) {
        pop(s);
    }
}

void printStack(Stack s) {
    cout << "Tamaño stack: " << s->sizeS << endl;
    SNodeST* node = s->node;
    cout << "[ ";
    while(node != NULL) {
        cout << node->value << " ";
        node = node->next;
    }
    cout << "]" << endl;
}

void printPointersStack(Stack s) {
    cout << "Tamaño stack: " << s->sizeS << endl;
    SNodeST* node = s->node;
    cout << "[ ";
    while(node != NULL) {
        cout << node << " ";
        node = node->next;
    }
    cout << "]" << endl;
}

