{4. Se cuenta con un archivo maestro de productos de una cadena de venta de alimentos congelados. De
cada producto se almacena la siguiente información: código de producto, nombre, descripción, stock
disponible, stock mínimo y precio.
Diariamente se recibe un archivo detalle por cada una de las 30 sucursales de la cadena. Cada archivo
detalle contiene: código de producto y cantidad vendida.
Se solicita desarrollar un procedimiento que reciba los 30 archivos detalle y actualice el stock del archivo
maestro.
Además, deberá generarse un archivo de texto que informe, para aquellos productos cuyo stock
disponible se encuentre por debajo del stock mínimo, los siguientes datos: nombre del producto,
descripción, stock disponible y precio.
Analizar alternativas para la generación de dicho informe: realizarlo en el mismo procedimiento de
actualización o en un procedimiento separado, indicando las ventajas y desventajas de cada opción.
Nota: Todos los archivos se encuentran ordenados por código de producto. En cada archivo detalle
puede haber cero, uno o más registros para un mismo producto.}

program Ejercicio4;
const
alto = 9999;
type
tipoMaestro = record
    codigo: integer;
    nombre: string;
    descripcion: string;
    stock: integer;
    min: integer;
    precio: real;
end;

tipoDetalle = record
    codigo: integer;
    cantidad: integer;
end;

tmaestro = file of tipoMaestro;
tdetalle = file of tipoDetalle;

vectorDetalles = array[1..30] of tdetalle;

vectorRegistros = array[1..30] of tipoDetalle;

procedure leer(var arch: tdetalle; var reg: tipoDetalle);
begin
    if(not Eof(arch)) then
        read(arch,reg)
    else
        reg.codigo := alto;
end;

procedure minimo(var archD: vectorDetalles; var regD: vectorRegistros; var min: tipoDetalle);
var
i: integer;
menor: Integer;
pos: Integer;
begin
    menor := alto;
    pos := -1;
    for i:= 1 to 30 do begin
        if (regD[i].codigo < menor) then begin
            pos := i;
            menor := regD[i].codigo;
        end;
    end;
    if(pos <> -1) then begin
        min := regD[pos];
        leer(archD[pos],regD[pos]);
    end
    else 
        min.codigo := alto;
end;
procedure actualizar(var archM: tmaestro; var archD: vectorDetalles;var archtxt: Text);
var
regD: vectorRegistros;
regM: tipoMaestro;
min: tipoDetalle;
total: Integer;
actual: Integer;
i: integer;
begin
    for i:= 1 to 30 do
      leer(archD[i],regD[i]);
    read(archM,regM);
    minimo(archD,regD,min);
    while(min.codigo <> alto) do begin
        actual := min.codigo;
        total := 0;
        while(min.codigo = actual) do begin 
            total := total + min.cantidad;
            minimo(archD,regD,min);
        end;
        while(regM.codigo <> actual) do begin
            read(archM,regM)
        end;
        regM.stock := regm.stock - total;
        if(regM.stock < regM.min) then
        begin
            WriteLn(archtxt,regm.nombre, ' ', regM.descripcion,' ', regm.stock,' ',regM.precio);
        end;
        seek(archM,FilePos(archM)-1);
        write(archM,regM);
        {if(not Eof(archM)) then
          read(archM,regM);}
    end;
end;

var 
archM: tmaestro;
archD: vectorDetalles;
archTxt: text;
i : integer;
nombre: string;
begin
    for i := 1 to 30 do begin
        str(i,nombre);
        nombre := 'detalle'+nombre+'.dat';
        Assign(archD[i],nombre);
        reset(archD[i]);
    end;
    Assign(archTxt,'informe.txt');
    Assign(archM,'maestro.dat');
    reset(archM);
    Rewrite(archtxt);
    actualizar(archM,archD,archTxt);
    close(archM);
    for i:= 1 to 30 do
      close(archD[i]);
    Close(archTxt);
end.