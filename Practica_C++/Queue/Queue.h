#include<iostream>
using namespace std;

typedef int ELEMENT_TYPE;

struct NodeQST {
    NodeQST* next;
    NodeQST* prev;
    ELEMENT_TYPE value;
};

struct QueueST
{
    NodeQST* firstIn;
    NodeQST* lastIn;
};

typedef QueueST* Queue;
typedef NodeQST* List;



Queue emptyQ();
bool isEmptyQ(Queue q);
void queue(Queue& q, ELEMENT_TYPE x);
ELEMENT_TYPE firstQ(Queue q);
void dequeue(Queue& q);
void destroyQ(Queue& q);

void printQ(Queue q);
