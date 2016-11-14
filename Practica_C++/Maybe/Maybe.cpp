#include "Maybe.h"

struct MaybeSt
{
	int num;
	bool isNt;
};

Maybe just(int n)
{
	Maybe m = new MaybeSt;
	m->num = n;
	m->isNt = false;
	return m;
};

Maybe nothing()
{
	Maybe m = new MaybeSt;
	m->isNt = true;
	return m;
}

bool isNothing(Maybe m)
{
	return m->isNt;
}

//Parcial cuando m es Nothing.
int fromJust(Maybe m)
{
	return m->num;
}
