{14. Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus próximos
vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la cantidad de asientos
disponibles. La empresa recibe todos los días dos archivos detalles para actualizar el archivo maestro.
En dichos archivos se tiene destino, fecha, hora de salida y cantidad de asientos comprados. 

Se sabe que los archivos están ordenados por destino más fecha y hora de salida, y que en los detalles pueden
venir 0, 1 ó más registros por cada uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje sin asiento
disponible.
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que tengan menos de
una cantidad específica de asientos disponibles. La misma debe ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}
program Ejercicio14;
const
alto = 'ZZZ';
type
master = record
    destino: string;
    fecha: string;
    salida: integer;
    cantidad: Integer;
end;
detalle = record
    destino: string;
    fecha: string;
    salida: integer;
    cantidad: Integer;
end;

tdetalle = file of detalle;
tmaster = file of master;

procedure leer(var archd: tdetalle; var reg: detalle);
begin
    if(not eof(archd)) then
        read(archd,reg)
    else 
        reg.destino:= alto;
end;    

procedure minimo(var archd1,archd2: tdetalle; var regd1,regd2,min: detalle);
begin
    if(regd1.destino < regd2.destino) or ((regd1.destino = regd2.destino) and (regd1.fecha < regd2.fecha))
    or ((regd1.destino = regd2.destino) and (regd1.fecha = regd2.fecha) and (regd1.salida < regd2.salida)) then begin 
        min:= regd1;
        leer(archd1,regd1);
    end
    else begin
        min:= regd2;
        leer(archd2,regd2);
    end;    
end;    

procedure leerMaestro(var archm: tmaster; var reg: master);
begin
    if(not eof(archm)) then
        read(archm,reg)
    else 
        reg.destino:= alto;
end;    

procedure actualizar(var archd1,archd2: tdetalle; var archm: tmaster);
var 
regd1,regd2,min: detalle;
regm: master;
lista: Text;
total,n: Integer;
begin
    writeln('ingrese la cantidad de asientos con la que quiera evaluar: ');
    readln(n);
    assign(lista,'lista.txt');
    Rewrite(lista);
    leer(archd1,regd1);
    leer(archd2,regd2);
    leerMaestro(archm,regm);
    minimo(archd1,archd2,regd1,regd2,min);
    while(regm.destino <> alto) do begin
        total:= 0;
        while(min.destino = regm.destino) and (min.fecha = regm.fecha) and (min.salida = regm.salida) do begin
            total:= total + min.cantidad;
            minimo(archd1,archd2,regd1,regd2,min);
        end;
        if(total <> 0 ) then begin
            regm.cantidad:= regm.cantidad - total;
            seek(archm,FilePos(archm)-1);
            Write(archm,regm);
        end;    
        if(regm.cantidad < n) then
            writeln(lista,regm.destino,regm.fecha,regm.salida);
        leerMaestro(archm,regm);
    end; 
    close(lista);   
end;    

var 
archd1,archd2: tdetalle;
archm: tmaster;
begin
    Assign(archd1,'detalle1.dat');
    assign(archd2,'detalle2.dat');
    assign(archm,'master.dat');
    reset(archd1);
    reset(archd2);
    Reset(archm);
    actualizar(archd1,archd2,archm);
    close(archd1);
    close(archd2);
    close(archm);
end.