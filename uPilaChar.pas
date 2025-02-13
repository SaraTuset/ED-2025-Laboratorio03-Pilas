unit uPilaChar;

interface

type
  TNodo = record
    data: Char;
    ant: ^TNodo
  end;

  TPila = ^TNodo;

procedure inicializar(var pila: TPila);
function esVacia(pila: TPila): Boolean;
procedure apilar(var pila: TPila; c: Char);
procedure desapilar(var pila: TPila);
function cima(pila: TPila): Char;

implementation

procedure inicializar(var pila: TPila);
begin
  pila := nil;
end;

function esVacia(pila: TPila): Boolean;
begin
  esVacia := pila = nil;
end;

procedure apilar(var pila: TPila; c: Char);
var
  aux: TPila;
begin
  new(aux);
  aux^.data:= c;
  aux^.ant:= pila;
  pila := aux;
end;

procedure desapilar(var pila: TPila);
var
  aux: TPila;
begin
  aux := pila;
  pila:= pila^.ant;
  dispose(aux);
end;

function cima(pila: TPila): Char;
begin
  if not esVacia(pila) then
     cima := pila^.data;
end;

end.
