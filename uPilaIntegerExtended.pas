unit uPilaIntegerExtended;

{ 
    Importante: Todos los ejercicios planteados son de índole académico. 
    Algunos de las funciones/procedimientos pueden no tener sentido práctico 
    para una pila ya que se deberían implementar con otro tipo de estructura.
}

interface

    uses
        sysutils;

    type
        tNodo = record
            info: integer;
            ant: ^tNodo;
        end;

        tPilaEnterosExt = record
            pila: ^tNodo;
            size: Integer;
        end;


    { Funciones básicas de las pilas }
    { Inicializa la pila }
    procedure initialize(var p: tPilaEnterosExt);
    { Agrega un elemento a la pila }
    procedure push(var p: tPilaEnterosExt; x: integer);
    { Elimina el elemento de la cima de la pila }
    procedure pop(var p: tPilaEnterosExt);
    { Devuelve el elemento de la cima de la pila }
    procedure peek(p: tPilaEnterosExt; var x: integer);
    { Devuelve true si la pila esta vacia }
    function isEmpty(p: tPilaEnterosExt): boolean;
    { Otros métodos }
    { Libera los recursos de la pila }
    procedure clear(var p: tPilaEnterosExt);
    { Imprime los elementos de la pila }
    function toString(p: tPilaEnterosExt): string;


    { ------------------------ Ejercicios ------------------------ }

    { 2.1 Contar el número de elementos en una pila. La operación debe hacerse en O(1) }
    function contarElementos(p: tPilaEnterosExt): integer;
    { 2.2 Obtener el elemento en la ultima posición de la pila }
    function ultimo(p: tPilaEnterosExt): integer;
    { 2.3 Combina dos pilas en una sola }
    procedure combinar(var p1, p2: tPilaEnterosExt);
    { 2.4 Hacer "pop" n veces }
    procedure popN(var p: tPilaEnterosExt; n: integer);
    { 2.5 Sumar los n primeros elementos de una pila y reemplazarlos por la suma }
    procedure sumarN(var p: tPilaEnterosExt; n: integer);
    { 2.6 Invertir pila }
    procedure invertir(var p: tPilaEnterosExt);
    { 2.7 Repetir n veces }
    procedure repetirN(var p: tPilaEnterosExt; n: integer);
    { 2.8 Contar apariciones de elemento n }
    function contarApariciones(var p: tPilaEnterosExt; n: integer): integer;






implementation

    { ------------------------ Funciones básicas de las pilas ------------------------ }

    { Inicializa la pila }
    procedure initialize(var p: tPilaEnterosExt);
    begin
        p.pila := nil; { Inicializa el cima de la pila a nil }
        p.size:= 0;
    end;

    { Devuelve true si la pila esta vacia }
    function isEmpty(p: tPilaEnterosExt): boolean;
    begin
        isEmpty := p.pila = nil; { Devuelve true si la cima es nil }
    end;

    { Agrega un elemento a la pila }
    procedure push(var p: tPilaEnterosExt; x: integer);
    var
        nuevo: ^tnodo;
    begin
        new(nuevo);        { Crea un nuevo nodo }
        nuevo^.info := x;  { Asigna el valor al nuevo nodo }
        nuevo^.ant := p.pila; { Enlaza el nuevo nodo con la anterior cima }
        p.pila := nuevo;   { Actualiza la cima de la pila }
        p.size += 1;
    end;

    { Elimina el elemento del cima de la pila }
    procedure pop(var p: tPilaEnterosExt);
    var
        aux: ^tnodo;
    begin
        if not isEmpty(p) then
        begin
            aux := p.pila;      { Guarda la cima de la pila en un nodo auxiliar }
            p.pila := p.pila^.ant; { Actualiza la cima de la pila }
            dispose(aux);        { Libera la memoria del nodo eliminado }
            p.size -= 1;
        end;
    end;

    { Devuelve el elemento la cima de la pila }
    procedure peek(p: tPilaEnterosExt; var x: integer);
    begin
        if not isEmpty(p) then
            x := p.pila^.info; { Devuelve el valor de la cima de la pila }
    end;

        { Libera los recursos de la pila }
    procedure clear(var p: tPilaEnterosExt);
    begin
        while not isEmpty(p) do
        begin
            pop(p); { Elimina los nodos de la pila }
        end;
    end;

    { Imprime los elementos de la pila }
    function toString(p: tPilaEnterosExt): string;
    var
        aux: ^tnodo;
        s: string;
    begin
        s := '';       { Inicializa la cadena de texto }
        if not isEmpty(p) then
        begin
            aux := p.pila; { Inicializa el nodo auxiliar con la cima de la pila }
            while aux <> nil do
            begin
                s := s + IntToStr(aux^.info) + ' '; { Concatena el valor del nodo con un espacio }
                aux := aux^.ant; { Avanza al nodo anterior }
            end;
        end;
        toString := s; { Devuelve la cadena de texto }
    end;

    { ------------------------ Ejercicios ------------------------ }

    { Para los ejemplos en los ejercicios utilizaremos una representación de pila de la siguiente forma:
        CIMA
        |
        \/
        [1, 2, 3, 4, 5]
    }


    {   
        2.1 Contar el número de elementos en una pila 
        Función que recibe una pila de enteros y devuelve la cantidad de elementos que contiene.
        La operación debe realizarse en O(1). Puede que sea necesario modificar la estructura de la pila...
        Entrada: pila de enteros
        Salida: cantidad de elementos de la pila, entero
        Ejemplos: 
            - contarElementos([1, 2, 3, 4, 5]) -> 5
            - contarElementos([]) -> 0
            - contarElementos([1, 2, 3]) -> 3
    }
    function contarElementos(p: tPilaEnterosExt): integer;
    begin
        contarElementos := p.size;
    end;

    { 
        2.2 Obtener el elemento en la ultima posición de la pila 
        Función que recibe una pila de enteros y devuelve el elemento que se encuentra en la última posición.
        Es decir, el primer elemento que se agregó a la pila.
        Entrada: pila de enteros
        Salida: elemento de la última posición, entero
        Ejemplos: 
            - ultimo([1, 2, 3, 4, 5]) -> 5
            - ultimo([]) -> 0
            - ultimo([1, 2, 3]) -> 3
    }
    function ultimo(p: tPilaEnterosExt): integer;
    var
        conteo: Integer;
    begin
        conteo := 0;
        while contarElementos(p) > 1 do
              pop(p);
        if not isEmpty(p) then
          conteo := p.pila^.info;
        ultimo := conteo;

    end;

    { 
        2.3 Combina dos pilas en una sola
        Procedimiento que recibe dos pilas de enteros y las combina en una sola.
        Entrada: dos pilas de enteros
        Salida: se modifica la primera pila con los elementos de ambas pilas. 
                El orden de los elementos de la segunda pila debe ser el mismo que el original.
        La segunda pila queda vacía.
        Ejemplos: 
            - combinar([1, 2, 3], [4, 5, 6]) -> [4, 5, 6, 1, 2, 3]
            - combinar([], [4, 5, 6]) -> [4, 5, 6]
            - combinar([1, 2, 3], []) -> [1, 2, 3]
    }
    procedure combinar(var p1, p2: tPilaEnterosExt);
    var
        p_aux: tPilaEnterosExt;
        aux: Integer;
    begin
        initialize(p_aux);
        while not isEmpty(p2) do
              begin
                   peek(p2, aux);
                   push(p_aux, aux);
                   pop(p2);
              end;
        while not isEmpty(p_aux) do
              begin
                   peek(p_aux, aux);
                   push(p1, aux);
                   pop(p_aux);
              end;
    end;

    { 
        2.4 Hacer "pop" n veces
        Procedimiento que recibe una pila de enteros y un entero n. 
        Realiza n operaciones de "pop" en la pila.
        Entrada: pila de enteros, entero n
        Salida: se modifica la pila eliminando los n elementos de la cima.
        Ejemplos: 
            - popN([1, 2, 3, 4, 5], 2) -> [3, 4, 5]
            - popN([1, 2, 3, 4, 5], 5) -> []
            - popN([1, 2, 3, 4, 5], 0) -> [1, 2, 3, 4, 5]
    }
    procedure popN(var p: tPilaEnterosExt; n: integer);
    begin  
        WriteLn('Implementa la función popN');
    end;

    { 
        2.5 Sumar los n primeros elementos de una pila y reemplazarlos por la suma
        Procedimiento que recibe una pila de enteros y un entero n. 
        Suma los n primeros elementos de la pila y reemplaza esos n elementos por la suma.
        Entrada: pila de enteros, entero n
        Salida: se modifica la pila reemplazando los n elementos por la suma de los mismos.
        Ejemplos: 
            - sumarN([1, 2, 3, 4, 5], 2) -> [3, 3, 4, 5]
            - sumarN([1, 2, 3, 4, 5], 5) -> [15]
            - sumarN([1, 2, 3, 4, 5], 0) -> [1, 2, 3, 4, 5]
    }
    procedure sumarN(var p: tPilaEnterosExt; n: integer);
    begin
        WriteLn('Implementa la función sumarN');
    end;

    { 
        2.6 Invertir pila
        Procedimiento que recibe una pila de enteros y la invierte.
        Entrada: pila de enteros
        Salida: se modifica la pila invirtiendo el orden de los elementos.
        Ejemplos: 
            - invertir([1, 2, 3, 4, 5]) -> [5, 4, 3, 2, 1]
            - invertir([]) -> []
            - invertir([1, 2, 3]) -> [3, 2, 1]
    }
    procedure invertir(var p: tPilaEnterosExt);
    begin
        WriteLn('Implementa la función invertir');
    end;

    { 
        2.7 Repetir n veces
        Procedimiento que recibe una pila de enteros y un entero n. 
        Repite n veces los elementos de la pila.
        Entrada: pila de enteros, entero n
        Salida: se modifica la pila repitiendo n veces los elementos.
        Ejemplos: 
            - repetirN([1, 2, 3], 2) -> [1, 1, 2, 2, 3, 3]
            - repetirN([1, 2, 3], 1) -> [1, 2, 3]
    }
    procedure repetirN(var p: tPilaEnterosExt; n: integer);
    begin
        WriteLn('Implementa la función repetirN');
    end;

    { 
        2.8 Contar apariciones de elemento n
        Función que recibe una pila de enteros y un entero n. 
        Devuelve la cantidad de veces que aparece el elemento n en la pila.
        Entrada: pila de enteros, entero n
        Salida: cantidad de apariciones del elemento n en la pila, entero
        Ejemplos: 
            - contarApariciones([1, 2, 3, 4, 5], 2) -> 1
            - contarApariciones([1, 2, 3, 4, 5], 10) -> 0
            - contarApariciones([1, 2, 3, 4, 5, 2], 2) -> 2
    }
    function contarApariciones(var p: tPilaEnterosExt; n: integer): integer;
    var
        aux: ^tNodo;
        count: Integer;
    begin
        aux := p.pila;
        count:= 0;
        while aux <> nil do
              begin
                 if aux^.info = n then
                 count += 1;
                 aux := aux^.ant;
              end;
        contarApariciones := count;
    end;

end.
