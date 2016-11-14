#include <iostream>
using namespace std;

//La implementación de este tipo Maybe es exclusivamente para números enteros.
struct MaybeSt;

typedef MaybeSt* Maybe;

Maybe just(int n);

Maybe nothing();

bool isNothing(Maybe m);

int fromJust();
