/*
 * Stack.h
 *
 *  Created on: 4 nov. 2016
 *      Author: aeen
 */
#include <iostream>

using namespace std;

struct StackSt;

typedef StackSt* Stack;

Stack emptyS();

bool isEmpty(Stack s);

void push(int x, Stack& s);

int top(Stack s);

void pop(Stack& s);

int size(Stack s);

void destroy(Stack& s);
