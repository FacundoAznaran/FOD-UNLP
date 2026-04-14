{5. Suponga que trabaja en una oficina donde se encuentra instalada una red local (LAN). La misma está
conformada por 5 máquinas conectadas entre sí y a un servidor central.
Semanalmente, cada máquina genera un archivo detalle de logs que registra las sesiones abiertas por los
usuarios en cada terminal, junto con su duración. Cada archivo contiene los siguientes campos: código de
usuario, fecha y tiempo de sesión.
Se solicita desarrollar un procedimiento que reciba los archivos detalle y genere un archivo maestro con la
siguiente información: código de usuario, fecha y tiempo total de sesiones abiertas.
Notas:
● Cada archivo detalle está ordenado por código de usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día, ya sea en la misma máquina o en
diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
}

program Ejercicio5;
const
alto = 99999;
type

Master = record
    codigo: Integer;
    fecha: string;
    tiempo: Integer;
end;

log = record
    codigo: integer;
    fecha: string;
    tiempo: integer;
end;

tdetalle = file of log;
tmaestro = file of Master;

vectorDetalles = array[1..5] of tdetalle;
vectorRegistros = array[1..5] of log;

procedure leer(var archd: tdetalle; var reg: log);
begin
    if(not eof(archd)) then
        Read(archd,reg)
    else 
        reg.codigo := alto;
end;   

procedure minimo(var archd: vectorDetalles; var regd: vectorRegistros; var min: log);
var
i,pos,menor: integer;
fechaM: string;
begin
        menor := alto;
        fechaM := 'ZZZZZ';
        pos := 1;
        for i:= 1 to 5 do begin
            if(regd[i].codigo < menor) or ((regd[i].codigo = menor) and (regd[i].fecha <= fechaM)) then begin
                pos:= i;
                menor:= regd[i].codigo;
                fechaM:= regd[i].fecha;
            end;    
        end;    
        min:= regd[pos];
        leer(archd[pos],regd[pos]);
end;    

procedure Merge(var archd: vectorDetalles; var archm: tmaestro);
var
regd: vectorRegistros;
total: Integer;
min: log;
aux: Master;
i: Integer;
begin
    for i:= 1 to 5 do
        leer(archd[i],regd[i]);
    minimo(archd,regd,min);
    while(min.codigo <> alto) do begin 
        aux.codigo:= min.codigo;
        while(min.codigo = aux.codigo) do begin {recorro todos los n usuarios}
            aux.fecha:= min.fecha;
            total:= 0;
            while(min.fecha = aux.fecha) and (min.codigo = aux.codigo)do begin {recorro las n fechas de los n usuarios}
                total:= total + min.tiempo;
                minimo(archd,regd,min);
            end;
            aux.tiempo:= total;
            write(archm,aux);
        end;    
    end;    
end;    

var 
archd: vectorDetalles;
archm: tmaestro;
i: Integer;
nombre: string;
begin
    for i:= 1 to 5 do begin
        str(i,nombre);
        nombre:= 'detalle'+nombre+'.dat';
        Assign(archd[i],nombre);
        Reset(archd[i]);
    end;    
    assign(archm,'/var/log/maestro.dat');
    Rewrite(archm);
    Merge(archd,archm);
    for i:= 1 to 5 do begin
        close(archd[i]);
    end;    
    Close(archm);
end.