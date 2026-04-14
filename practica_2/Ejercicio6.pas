{6. Se desea modelar la información necesaria para un sistema de recuento de casos de COVID del
Ministerio de Salud de la Provincia de Buenos Aires.
Diariamente se reciben 10 archivos detalle provenientes de distintos municipios. La información contenida
en cada uno de ellos es la siguiente: código de localidad, código de cepa, cantidad de casos activos,
cantidad de casos nuevos, cantidad de casos recuperados y cantidad de casos fallecidos.
El ministerio cuenta con un archivo maestro que almacena la siguiente información: código de localidad,
nombre de la localidad, código de cepa, nombre de la cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de casos recuperados y cantidad de casos fallecidos.
Todos los archivos están ordenados por código de localidad y código de cepa.
Se solicita desarrollar el procedimiento que permita actualizar el archivo maestro a partir de los 10 archivos
detalle, teniendo en cuenta el siguiente criterio:
● A la cantidad de casos fallecidos del maestro se le debe sumar el valor recibido en el detalle.
● A la cantidad de casos recuperados del maestro se le debe sumar el valor recibido en el detalle.
● La cantidad de casos activos del maestro debe actualizarse con el valor recibido en el detalle.
● La cantidad de casos nuevos del maestro debe actualizarse con el valor recibido en el detalle.
Realizar las declaraciones necesarias, el programa principal y los procedimientos que se requieran para
efectuar la actualización solicitada.
Además, informar la cantidad de localidades que poseen más de 50 casos activos, independientemente de
que hayan sido actualizadas o no.}
program Ejercicio6;
const
alto = 99999;
type

Master = record
    nlocalidad: string;
    localidad: integer;
    ncepa: string;
    cepa: integer;
    activos: integer;
    nuevos: Integer;
    recuperados: integer;
    fallecidos: Integer;
end;

informe = record
    localidad: integer;
    cepa: integer;
    activos: integer;
    nuevos: Integer;
    recuperados: integer;
    fallecidos: Integer;
end;

tdetalle = file of informe;
tmaestro = file of Master;

vectorDetalles = array[1..10] of tdetalle;
vectorRegistros = array[1..10] of informe;

procedure leer(var arch: tdetalle; var reg: informe);
begin
    if(not eof(arch))then
        read(arch,reg)
    else
        reg.localidad:= alto;
end;    

function esMenor(reg1,reg2: informe): Boolean;
begin
    esMenor := (reg1.localidad < reg2.localidad) or ((reg1.localidad = reg2.localidad) and (reg1.cepa < reg2.cepa));
end;    

procedure minimo(var archd: vectorDetalles; var regd: vectorRegistros; var min: informe);
var 
i,pos: Integer;
begin
    pos:= 1;
    for i:= 2 to 10 do begin
        if(esMenor(regd[i],regd[pos])) then
            pos:= i;
    end;   
    min:= regd[pos];
    leer(archd[pos],regd[pos]);
end;    

function evaluar(var archm: tmaestro): integer;
var
sum,cant: Integer;
reg: Master;
actual: integer;
begin
    seek(archm,0);
    read(archm,reg);
    cant:= 0;
    while(reg.localidad <> alto) do begin
        actual:= reg.localidad;
        sum:= 0;
        while(reg.localidad = actual) do begin
            sum:= sum + reg.activos;
            if(not eof(archm)) then
                read(archm,reg)
            else 
                reg.localidad:= alto;
        end;    
        if(sum > 50) then
            cant:= cant + 1;
    end; 
    evaluar:= cant;
end;        

procedure actualizar(var archd: vectorDetalles; var archm: tmaestro);
var
regm: Master;
aux,min: informe;
regd: vectorRegistros;
i,cantidad: Integer;
begin
    read(archm,regm);
    for i:= 1 to 10 do
        leer(archd[i],regd[i]);
    minimo(archd,regd,min);
    while(min.localidad <> alto) do begin
        aux.localidad := min.localidad;
        while(min.localidad = aux.localidad) do begin
            aux.cepa:= min.cepa;
            aux.activos:= 0;
            aux.nuevos:= 0;
            aux.recuperados:= 0;
            aux.fallecidos:= 0;
            while(min.localidad = aux.localidad) and (min.cepa = aux.cepa) do begin
                aux.activos:= aux.activos + min.activos;
                aux.nuevos:= aux.nuevos + min.nuevos;
                aux.recuperados:= aux.recuperados + min.recuperados;
                aux.fallecidos:= aux.fallecidos + min.fallecidos;
                minimo(archd,regd,min);
            end;
            while(regm.localidad <> aux.localidad) or (regm.localidad = aux.localidad) and (regm.cepa <> aux.cepa)do
                read(archm,regm);
            regm.fallecidos:= regm.fallecidos + aux.fallecidos;
            regm.recuperados:= regm.recuperados + aux.recuperados;
            regm.activos:= aux.activos;
            regm.nuevos:= aux.nuevos;
            seek(archm,FilePos(archm)-1);
            Write(archm,regm); 
        end;   
    end;
    cantidad:= evaluar(archm);
    writeln('Localidades con mas de 50 activos: ', cantidad);
end;
var 
archd: vectorDetalles;
archm: tmaestro;
i: integer;
nombre: string;
begin   
    for i:= 1 to 10 do begin
        str(i,nombre);
        nombre:= 'detalle'+nombre+'.dat';
        Assign(archd[i],nombre);
        Reset(archd[i]);
    end;    
    Assign(archm,'maestro.dat');
    Reset(archm);
    actualizar(archd,archm);
    close(archm);
    for i:= 1 to 10 do
        Close(archd[i]);
end.    