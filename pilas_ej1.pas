program pilas_ej1;

uses
    sysutils, 
    uPilaChar;


{ 1.2
    Define una función balanceada para comprobar el balance de paréntesis de una expresión aritmética.
    Una expresión aritmética está balanceada si cada paréntesis de apertura tiene un paréntesis de cierre correspondiente.
    Los paréntesis deben estar correctamente anidados.
    No se comprobará si los paréntesis están en el lugar correcto (por ejemplo, (3+2*)5 o 3(+4-)2 no es una expresión aritmética 
    válida pero vamos a considerarla balanceada).
    - Entradas:
        - Una cadena de caracteres que representa una expresión aritmética.
    - Salida:
        - Devuelve true si la expresión está balanceada, es decir, si los paréntesis están correctamente cerrados y anidados.
    - Ejemplos
        - (3+2)*5 -> true
        - 3+(4-2 -> false
        - (3+2)*5+(4-2) -> true
        - (3(+2)*5)+(4-2 -> false
}

{ 1.3
    Mejora la función balanceada para que compruebe también los corchetes.
    - Entradas:
        - Una cadena de caracteres que representa una expresión aritmética.
    - Salida:
        - Devuelve true si la expresión está balanceada, es decir, si los paréntesis y corchetes están correctamente cerrados y anidados.
    - Ejemplos
        - (3+2)*5 -> true
        - 3+(4-2 -> false
        - (3+2)*5+(4-2) -> true
        - (3(+2)*5)+(4-2 -> false
        - [3+2]*5 -> true
        - 3+[4-2 -> false
        - [3+2]*5+[4-2] -> true
        - [3[+2]*5]+[4-2] -> false

}

const
    expresion1 = '(3+2)*5';
    resultado1 = true;
    expresion2 = '3+(4-2';
    resultado2 = false;
    expresion3 = '(3+2)*5+(4-2)';
    resultado3 = true;
    expresion4 = '(3(+2)*5)+(4-2';
    resultado4 = false;
    expresion5 = '[3+2]*5';
    resultado5 = true;
    expresion6 = '3+[4-2';
    resultado6 = false;
    expresion7 = '[3+2]*5+[4-2]';
    resultado7 = true;
    expresion8 = '[3[+2]*5]+[4-2)';
    resultado8 = false;
    expresion9 = '[3[+2]*5)+[4-2]';
    resultado9 = false;
    expresion10 = '(3[+2]*5(+[4-2]';
    resultado10 = false;
    expresion11 = '(3[+2]*5)+[4-2]';
    resultado11 = true;
    expresion12 = '(3[+2)*5]+[4-2]';
    resultado12 = false;


{ 1.2}
function balanceada(exp: string): boolean;
var
  pila: TPila;
  i: Integer;
begin
    inicializar(pila);
    for i:= 1 to Length(exp) do
        if exp[i] = '(' then
           apilar(pila, exp[i])
        else if exp[i] = ')' then
           if not esVacia(pila) then
              desapilar(pila)
           else
             begin
               balanceada := False;
               apilar(pila, exp[i]);
             end;
    balanceada :=  esVacia(pila);
end;


{ 1.3}
function balanceadaCorchetes(exp: string): boolean;
var
  pila: TPila;
  i: Integer;
begin
    inicializar(pila);
    for i:= 1 to Length(exp) do
        begin
          if (exp[i] = '(') or (exp[i] = '[') then
             apilar(pila, exp[i])
          else if exp[i] = ')' then
             if cima(pila) = '(' then
                desapilar(pila)
             else
                 balanceadaCorchetes := False
          else if exp[i] = ']' then
             if cima(pila) = '[' then
                desapilar(pila)
             else
                 balanceadaCorchetes := False;
        end;
    balanceadaCorchetes := esVacia(pila);
end;

function showOkWrong(ok: boolean): string;
begin
    if ok then
        showOkWrong := 'OK'
    else
        showOkWrong := 'ERROR';
end;


begin
    WriteLn('Ejemplo #', '  Expresión', #9#9, 'Res = Esp', #9, 'OK/ERROR');
    WriteLn('---------------------------------------------------------');
    WriteLn('Ejemplo 1: ', expresion1, #9#9, balanceada(expresion1), ' = ', resultado1, #9, showOkWrong(balanceada(expresion1) = resultado1));
    WriteLn('Ejemplo 2: ', expresion2, #9#9, balanceada(expresion2), ' = ', resultado2, #9, showOkWrong(balanceada(expresion2) = resultado2));
    WriteLn('Ejemplo 3: ', expresion3, #9, balanceada(expresion3), ' = ', resultado3, #9, showOkWrong(balanceada(expresion3) = resultado3));
    WriteLn('Ejemplo 4: ', expresion4, #9, balanceada(expresion4), ' = ', resultado4, #9, showOkWrong(balanceada(expresion4) = resultado4));
    WriteLn('Ejemplo 5: ', expresion5, #9#9, balanceadaCorchetes(expresion5), ' = ', resultado5, #9, showOkWrong(balanceadaCorchetes(expresion5) = resultado5));
    WriteLn('Ejemplo 6: ', expresion6, #9#9, balanceadaCorchetes(expresion6), ' = ', resultado6, #9, showOkWrong(balanceadaCorchetes(expresion6) = resultado6));
    WriteLn('Ejemplo 7: ', expresion7, #9, balanceadaCorchetes(expresion7), ' = ', resultado7, #9, showOkWrong(balanceadaCorchetes(expresion7) = resultado7));
    WriteLn('Ejemplo 8: ', expresion8, #9, balanceadaCorchetes(expresion8), ' = ', resultado8, #9, showOkWrong(balanceadaCorchetes(expresion8) = resultado8));
    WriteLn('Ejemplo 9: ', expresion9, #9, balanceadaCorchetes(expresion9), ' = ', resultado9, #9, showOkWrong(balanceadaCorchetes(expresion9) = resultado9));
    WriteLn('Ejemplo 10: ', expresion10, #9, balanceadaCorchetes(expresion10), ' = ', resultado10, #9, showOkWrong(balanceadaCorchetes(expresion10) = resultado10));
    WriteLn('Ejemplo 11: ', expresion11, #9, balanceadaCorchetes(expresion11), ' = ', resultado11, #9, showOkWrong(balanceadaCorchetes(expresion11) = resultado11));
    WriteLn('Ejemplo 12: ', expresion12, #9, balanceadaCorchetes(expresion12), ' = ', resultado12, #9, showOkWrong(balanceadaCorchetes(expresion12) = resultado12));
    readln;
end.




    

