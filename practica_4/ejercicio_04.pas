{a. PosicionarYLeerNodo(): Indique qué hace y la forma en que deben ser enviados los
parámetros (valor o referencia). Implemente este módulo en Pascal.
b. claveEncontrada(): Indique qué hace y la forma en que deben ser enviados los
parámetros (valor o referencia). ¿Cómo lo implementaría?
c. ¿Existe algún error en este código? En caso afirmativo, modifique lo que considere necesario.
d. ¿Qué cambios son necesarios en el procedimiento de búsqueda implementado sobre un
árbol B para que funcione en un árbol B+?
RTA D:
si claveEncontrada da true en un nodo que no es hoja, el algoritmo no debe detenerse. 
debe continuar recursivamente bajando por el hijo[pos] hasta alcanzar el nivel de las hojas. 
recien cuando este parado en una hoja y la clave coincide, puede decir que encontro el dato final, 
guardar el NRR_encontrado, y retornar true.}

program ejercicio_04;
const 
m = 43;
type

procedure posicionarYLeerNodo(var A: archivo; var nodo: DatoArbol; NRR: integer);
begin   
    seek(A,NRR);
    read(A,nodo);
end;

procedure claveEncontrada(nodo: DatoArbol; clave: integer;var pos: integer; var clave_encontrada: boolean);
var
i: integer;
begin
    i := 1;
    while(nodo.claves[i] < clave) and (i <= nodo.cant_Claves) do begin
        i := i + 1;
    if(i <= nodo.cant_Claves) and (nodo.claves[i] = clave) then 
        clave_encontrada = true;
    
    pos:= i;
end;
procedure buscar(var A: archivo; NRR, clave: integer; var NRR_encontrado, pos_encontrada, resultado: integer)
var clave_encontrada: boolean;
begin
    if (nodo = null)                                     //if(NRR = -1)
        resultado := false; {clave no encontrada}        //  resultado := false;
    else begin
        posicionarYLeerNodo(A, nodo, NRR);
        claveEncontrada(nodo, clave, pos, clave_encontrada);
        if (clave_encontrada) then begin
            NRR_encontrado := NRR; { NRR actual }
            pos_encontrada := pos; { posicion dentro del array }
            resultado := true;
        end
        else
            buscar(A,nodo.hijos[pos], clave, NRR_encontrado, pos_encontrada, resultado)
    end;
end;