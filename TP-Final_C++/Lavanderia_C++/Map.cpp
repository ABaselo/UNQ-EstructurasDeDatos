#include "Map.h"

/*
INVARIANTE DE REPRESENTACION
----------------------------
- Dado un Map con claves del tipo 'string' y valores del tipo 'Cliente', el cual es
  representado por un arbol BST balanceado:
    * No existen claves repetidas.
*/

///////////////////////////////////////////////
/// OPERACIONES SOBRE AVL
///////////////////////////////////////////////

// Prop.: crea una hoja con determinado cliente
AVL leafAVL(Cliente c) {
    AVLNode* node = new AVLNode;
    node->height = 1;
    node->left   = NULL;
    node->right  = NULL;
    node->kv     = c;
    return node;
}

// Prop.: devuelve la altura de un AVL
int heightAVL(AVL t) {
    return t == NULL ? 0 : t->height;
}

// Prop.: hace una rotación simple
AVL sJoinAVL(Cliente kv, AVL ti, AVL td) {
    AVL node      = leafAVL(kv);
    node->height  = 1 + max(heightAVL(ti), heightAVL(td));
    node->left    = ti;
    node->right   = td;
    return node;
}

/// PRECOND: ti es dos más profundo que td (y por lo tanto es no vacio
// Prop.: realiza una rotación a izquierda
AVL lJoinAVL(Cliente kv, AVL ti, AVL td) {
    Cliente kvi = ti->kv;
    AVL tii     = ti->left;
    AVL tid     = ti->right;
    int hii     = heightAVL(tii);
    int hid     = heightAVL(tid);
    if (hii >= hid) {
        return sJoinAVL(kvi, tii, sJoinAVL(kv, tid, td));
    }

    Cliente kvid = tid->kv;
    AVL tidi     = tid->left;
    AVL tidd     = tid->right;
    return sJoinAVL(kvid, sJoinAVL(kvi, tii, tidi), sJoinAVL(kv, tidd, td));
}

/// PRECOND: td es dos más profundo que ti (y por lo tanto es no vacio)
// Prop.: realiza una rotación a derecha
AVL rJoinAVL(Cliente kv, AVL ti, AVL td) {
    Cliente kvd = td->kv;
    AVL tdi     = td->left;
    AVL tdd     = td->right;
    int hdi = heightAVL(tdi);
    int hdd = heightAVL(tdd);
    if (hdi <= hdd) {
        return sJoinAVL(kvd, sJoinAVL(kv, ti, tdi), tdd);
    }

    Cliente kvdi = tdi->kv;
    AVL tdii = tdi->left;
    AVL tdid = tdi->right;
    return sJoinAVL(kvdi, sJoinAVL(kv, ti, tdii), sJoinAVL(kvd, tdid, tdd));
}

/**
PRECOND:
  * ti y td son BSTs
  * las claves de ti son menores que kv
  * las claves de td son mayores que kv
  * ti y td son AVLs
  * PERO ti y td pueden tener mas altura que lo necesario!!! (pero no deben!)
     (ojo: ti dos mas que td, o td dos mas que ti, pues antes eran AVLs...)
**/
// Prop.: realiza una rotación en base a las alturas
AVL joinAVL(Cliente c, AVL ti, AVL td) {
    int hi = heightAVL(ti);
    int hd = heightAVL(td);
    if (abs(hi-hd) <= 1) {
        return sJoinAVL(c, ti, td);
    } else if (hi == hd + 2) {
        return lJoinAVL(c, ti, td);
    } else if (hd == hi + 2) {
        return rJoinAVL(c, ti, td);
    }
    // nunca puede darse otro caso
    cout << "Se viola el invariante de representación!" << endl;
}

/// PRECOND: el AVL no está vacío
// Prop.: asigna el minimo al primer parametro y devuelve "t" sin ese minimo
AVL splitMaxAVL(Cliente& c, AVL t) {
    if(t->right == NULL) {
        Cliente cliente = t->kv;
        AVL left        = t->left;
        delete t->right;
        delete t;
        c  = cliente;
        return left;
    } else {
        AVL td = splitMaxAVL(c, t->right);
        return joinAVL(t->kv, t->left, td);
    }
}

///////////////////////////////////////////////
/// INTERFAZ DE MAP Y AUXILIARES
///////////////////////////////////////////////

/**
Prop.: Crea un Map vacio.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Solo retorna NULL.
Map emptyM() {
    return NULL;
}

/**
Prop.: Devuelve un value dado una 'key'. Retorna NULL en caso de encontrar la 'key' dada.
Prec.: Ninguna.
*/
//O(log n), con n = cantidad de pares key-value mapeadas.
//Justificacion: Al ser un arbol BST el costo de una busqueda en peor caso es logaritmico.
Cliente lookupM(Map& m, string key) {
    if(m == NULL)
        return NULL;

    if(getCuit(m->kv) == key)
        return m->kv;
    else
    {
        if(getCuit(m->kv) > key)
            return lookupM(m->left,key);
        else
            return lookupM(m->right,key);
    }
}


/**
Prop.: Asocia un key con un value. Si el cliente ya existía previamente dentro del map no se hace nada.
Prec.: Ninguna.
*/
//O(log n), con n = cantidad de pares key-value mapeadas.
//Justificacion: Al ser un arbol BST el costo de una insercion en peor caso es logaritmico.
void addM(Map& m, Cliente cliente) {
    if(m == NULL)
        m = leafAVL(cliente);
    else
    {
        if(getCuit(m->kv) < getCuit(cliente))
           addM(m->right,cliente);
        else
			if(getCuit(m->kv) > getCuit(cliente))
				addM(m->left,cliente);
			else// el cliente ya existía previamente en el map...
				return;
    }

    m = joinAVL(m->kv, m->left, m->right);
}

/*
// Un addM implementado de forma iterativa sobre el BST.
// No se utiliza en este tp debido a que el BST queda desbalanceado y no encontre la forma de solucionarlo.
void addM(Map& m, Cliente cliente) {
    if(m == NULL)
    {
        m = leafAVL(cliente);
        return;
    }

	string key = getCuit(cliente);
	Map parent;
    Map current = m;

    while(current != NULL)
    {
		parent = current;
		if(key < getCuit(current->kv))
			current = current->left;
		else
            if(key > getCuit(current->kv))
                current = current->right;
            else// se encontro 'key' en el mapa...
                return;

		m = joinAVL(m->kv, m->left, m->right);
    }

    if(key < getCuit(parent->kv))
			parent->left = leafAVL(cliente);
	else
		if(key > getCuit(parent->kv))
			parent->right = leafAVL(cliente);

}
*/

/**
Prop.: Indica si la respuesta del lookup es válida.
Prec.: Ninguna.
*/
//O(1)
//Justificacion: Se evalua una operacion booleana y se retorna el resultado.
bool isNothing(Cliente c) {
    return c == NULL;
}

/**
Prop.: Elimina un value dado una key. Si la key buscada no se encuentra en el map se deja el map como estaba.
Prec.: Ninguna.
*/
//O(log n), con n = cantidad de pares key-value mapeadas.
//Justificacion: Al ser un arbol BST el costo de eliminar en peor caso es logaritmico.
void removeM(Map& m, string key) {
    if(m == NULL) {
        return;
    }

    if(getCuit(m->kv) == key) {
       if(m->left == NULL) {
		  Map tmp = m;
          m = m->right;

          destroyCliente(tmp->kv);  //O(1)
          delete m;

          return;
       } else {
        cout << "no es left" << endl;
          m->left = splitMaxAVL(m->kv, m->left);
       }
    } else if(getCuit(m->kv) > key) {
        removeM(m->left, key);
    } else if(getCuit(m->kv) < key) {
        removeM(m->right, key);
    }

    m = joinAVL(m->kv, m->left, m->right);
}

//O(n), con n = cantidad de clientes en el map. Debe recorrer cada nodo del BST para obtener todas las key del map.
void domMAux(Map& m, ArrayList& xs) {
	if(m == NULL)
		return;
    add(xs, getCuit(m->kv));
    domMAux(m->left, xs);
    domMAux(m->right, xs);
}

/**
Prop.: Devuelve la lista de claves de un Map.
Prec.: Ninguna.
*/
//O(n), con n =  cantidad de pares key-value mapeadas.
//Justificacion: La operacion mas costosa es domMAux, la cual es O(n).
ArrayList domM(Map& m) {
	ArrayList lsDom = crearArrayList();
    domMAux(m, lsDom);

    return lsDom;
}

/**
Prop.: Libera la memoria de un Map.
Prec.: Ninguna.
*/
//O(n), con n = cantidad de pares key-value en el map.
//Justificacion: Debe recorrer cada nodo del BST para destruirlos.
void destroyM(Map& m) {
	if(m == NULL)
		return;

    destroyM(m->left);
    destroyM(m->right);
    destroyCliente(m->kv);
    delete m;
    m = NULL;
}

void emptySpace(int i) {
    for(; i > 0; i--) {
        cout << "-";
    }
}

///////////////////////////////////////////////
/// PRINT DEL MAP (para ver AVL como usuario)
/// NOTAR QUE ROMPE ENCAPSULAMIENTO
/// PERO AYUDA A VER EL ARBOL HASTA TENER
/// BIEN LA IMPLEMENTACION
///////////////////////////////////////////////

void printMapAux(Map m, int i) {

    if(m == NULL) {
        emptySpace(i);
        cout << "NULL";
        return;
    }

    emptySpace(i);
    cout << "ROOT ";
    cout << getCuit(m->kv) << endl;

    emptySpace(i);
    printMapAux(m->left, i+1);
    cout << endl;

    emptySpace(i);
    printMapAux(m->right, i+1);
    cout << endl;
}

void printMap(Map m) {
     printMapAux(m, 0);
}
