{17. Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con información de las
motos que posee a la venta. De cada moto se registra: código, nombre, descripción, modelo, marca y
stock actual. Mensualmente se reciben 10 archivos detalles con información de las ventas de cada uno
de los 10 empleados que trabajan. De cada archivo detalle se dispone de la siguiente información:
código de moto, precio y fecha de la venta. Se debe realizar un proceso que actualice el stock del
archivo maestro desde los archivos detalles. Además se debe informar cuál fue la moto más vendida.

NOTA: Todos los archivos están ordenados por código de la moto y el archivo maestro debe ser recorrido
sólo una vez y en forma simultánea con los detalles.}
program Ejercicio17;
const
alto = 9999;
type
master = record
    codigo: integer;
    nombre: string;
    descripcion: string;
    modelo: string;
    marca: string;
    stock: Integer;
end;
ventas = record
    codigo: integer;
    precio: real;
    fecha: String;
end;
tmaster = file of master;
tdetalle= file of ventas;

vectorDetalle = array[1..10] of tdetalle;
vectorRegistros = array[1..10] of ventas;

procedure leer(var arch: tdetalle; var reg:ventas);
begin
    if(not eof(arch)) then
        read(arch,reg)
    else 
        reg.codigo:= alto;
end;    

procedure minimo(var archd: vectorDetalle; var regd: vectorRegistros; var min: ventas);
var
i,pos: Integer;
begin
    pos:= 1;
    for i:= 2 to 10 do begin
        if(regd[i].codigo < regd[pos].codigo) then
            pos:= i;
    end;
    min:= regd[pos];
    leer(archd[pos],regd[pos]);
end;    

procedure actualizar(var archd: vectorDetalle; var archm: tmaster);
var
min: ventas;
regd: vectorRegistros;
regm: master;
total,codMax,totalMax,i,actual : Integer;
begin
    read(archm,regm);
    for i:= 1 to 10 do 
        leer(archd[i],regd[i]);
    minimo(archd,regd,min);
    codMax:= 0;
    totalMax:= 0;
    while(min.codigo <> alto) do begin
        total:= 0;
        actual:= min.codigo;
        while(min.codigo = actual) do begin
            total:= total + 1;
            minimo(archd,regd,min);
        end;    
        if(total > totalMax) then begin
            totalMax:= total;
            codMax:= actual;
        end;    
        while(regm.codigo <> actual) do 
            read(archm,regm);
        regm.stock:= regm.stock - total;
        seek(archm,FilePos(archm)-1);
        Write(archm,regm);
    end;    
    writeln('Moto más vendida, código: ', codMax, ' con ', totalMax, ' unidades');
end;    

var 
archd: vectorDetalle;
archm: tmaster;
i: integer;
nombre: String;
begin
    for i := 1 to 10 do begin
        str(i,nombre);
        nombre:= 'detalle'+nombre+'.dat';
        Assign(archd[i],nombre);
        reset(archd[i]);
    end;    
    assign(archm,'master.dat');
    reset(archm);
    actualizar(archd,archm);
    for i:= 1 to 10 do
        close(archd[i]);
    close(archm);
end. 