#include <iostream>
using namespace std;

struct SNodeST
{
    int value;
    SNodeST* next;
};

struct StackST
{
    SNodeST* node;
    int sizeS;
};

typedef StackST* Stack;

Stack emptyS();

bool isEmptyS(Stack s);

void push(int x, Stack& s);

int top(Stack s);

void pop(Stack& s);

int sizeS(Stack s);

void destroyS(Stack& s);

void printStack(Stack s);

void printPointersStack(Stack s);
