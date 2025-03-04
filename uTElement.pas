unit uTElement;

interface

type
    TElement = record
        titulo: string[50];
        autor: string[50];
        ISBN: string[50];
        idioma: string[50];
        numPaginas: integer
    end;

procedure assign(var e: TElement; e2 : TElement);
function toString(e: TElement): string;

implementation

uses sysutils;

procedure assign(var e: TElement; e2 : TElement);
begin
    e.titulo:= e2.titulo;
    e.autor:= e2.autor;
    e.idioma:= e2.idioma;
    e.ISBN:= e2.ISBN;
    e.numPaginas:= e2.numPaginas;
end;

function toString(e: TElement): string;
begin
    toString := '(titulo: ' + e.titulo + ', autor: ' + e.autor + ', idioma: ' + e.idioma + ', ISBN: ' + e.ISBN + ', paginas: ' + IntToStr(e.numPaginas) + ')';
end;

end.
