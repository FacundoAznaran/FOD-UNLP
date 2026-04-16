{15. Se desea modelar la información de una ONG dedicada a la asistencia de personas con carencias
habitacionales. La ONG cuenta con un archivo maestro conteniendo información como se indica a
continuación: Código pcia, nombre provincia, código de localidad, nombre de localidad, #viviendas sin
luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin agua, # viviendas sin sanitarios.      

Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras de ayuda en
la edificación y equipamientos de viviendas en cada provincia. La información de los detalles es la
siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas construidas, #viviendas con
agua, #viviendas con gas, #entrega sanitarios.

Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben
10 detalles. Todos los archivos están ordenados por código de provincia y código de localidad.

Para la actualización del archivo maestro, se debe proceder de la siguiente manera:

● Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
● Idem para viviendas sin agua, sin gas y sin sanitarios.
● A las viviendas de chapa se le resta el valor recibido de viviendas construidas

La misma combinación de provincia y localidad aparecen a lo sumo una única vez.

Realice las declaraciones necesarias, el programa principal y los procedimientos que requiera para la
actualización solicitada e informe cantidad de localidades sin viviendas de chapa (las localidades pueden
o no haber sido actualizadas).}
program Ejercicio15;
const
alto = 99999;
type
master = record
    codigo: integer;
    nombre: string;
    localidad: integer;
    nombre_localidad: string;
    luz: integer;
    gas: integer;
    chapa: integer;
    agua: integer;
    sanitarios: integer;
end;
detalle = record
    codigo: integer;
    localidad: integer;
    luz: integer;
    gas: integer;
    chapa: integer;
    agua: integer;
    sanitarios: integer;
end;
tmaster = file of master;
tdetalle = file of detalle;

vectorDetalle = array[1..10] of tdetalle;
vectorRegistro= array [1..10] of detalle;

procedure leer(var archd: tdetalle; var reg: detalle);
begin
    if(not eof(archd)) then
        read(archd,reg)
    else       
        reg.codigo:= alto;
end;    

procedure leerMaster(var archm: tmaster; var reg: master);
begin
    if(not eof(archm)) then
        read(archm,reg)
    else 
        reg.codigo:= alto;
end;    

procedure minimo(var archd: vectorDetalle; var regd: vectorRegistro; var min: detalle);
var
pos,i: integer;
begin
    pos:= 1;
    for i:= 2 to 10 do begin
        if(regd[i].codigo < regd[pos].codigo) or 
        ((regd[i].codigo = regd[pos].codigo) and (regd[i].localidad < regd[pos].localidad)) then
            pos:= i;
    end;    
    min:= regd[pos];
    leer(archd[pos],regd[pos]);
end;    

procedure actualizar(var archd: vectorDetalle; var archm: tmaster);
var 
regd: vectorRegistro;
regm: master;
min: detalle;
i,cantidad: integer;
begin
    leerMaster(archm,regm);
    cantidad:= 0;
    for i:= 1 to 10 do
        leer(archd[i],regd[i]);
    minimo(archd,regd,min);
    while(regm.codigo <> alto) do begin
        if(regm.codigo = min.codigo) and (regm.localidad = min.localidad) then begin
            regm.luz:= regm.luz - min.luz;
            regm.gas:= regm.gas - min.gas;
            regm.sanitarios:= regm.sanitarios - min.sanitarios;
            regm.agua:= regm.agua - min.agua;
            regm.chapa:= regm.chapa - min.chapa;
            Seek(archm,FilePos(archm)-1);
            Write(archm,regm);
            minimo(archd,regd,min);
        end;    
        if(regm.chapa = 0) then
            cantidad := cantidad + 1;
        leerMaster(archm,regm);
    end;  
    WriteLn('la cantidad de localidades sin casas de chapa es de: ',cantidad);  
end;    

var 
archd: vectorDetalle;
archm: tmaster;
i: integer;
nombre: string;
begin
    for i:= 1 to 10 do begin
        str(i,nombre);
        nombre:= 'detalle'+nombre+'.dat';
        Assign(archd[i],nombre);
        reset(archd[i]);
    end;    
    assign(archm,'master.dat');
    reset(archm);
    actualizar(archd,archm);
    close(archm);
    for i:= 1 to 10 do
        close(archd[i]);
end. 