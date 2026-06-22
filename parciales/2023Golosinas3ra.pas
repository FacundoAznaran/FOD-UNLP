program fdajkslsjk;

const
alto = 99999;
type
producto = record;
    codigo: integer;
    nombre: string;
    precio: real;
    stockA: integer;
    stockMin: integer;
end;
venta = record
    codigo: integer;
    cantidad: integer;
end;
master = file of producto;
detalle = file of venta;
vDetalle = array[1..20] of detalle;
vregistros = array[1..20] of venta;

procedure leer(var archD: detalle; var reg: venta);
begin
    if(not EOF(archD)) then
        read(archD,reg)
    else
        reg.codigo:= alto;
end;

procedure minimo(var archD: vDetalle; var vreg: vregistros;var min: venta);
var
i,pos: integer;
begin
    pos:= -1;
    min.codigo:= alto;
    for i := 1 to 20 do begin
        if(min.codigo > vreg[i].codigo) then begin
            min.codigo := vreg[i].codigo;
            pos:= i;
        end;
    end;
    if(pos <> -1) then begin
        min:= vreg[pos];
        leer(archD[pos],vreg[pos]);
    end;
end;

procedure actualizar(var archD: vDetalle; var archM: master);
var
i: integer;
vreg: vregistros;
min,actual: venta;
regM: producto;
informe: text;
begin
    for i:= 1 to 20 do begin
        reset(archD[i]);
        leer(archD[i],vreg[i]);
    end;
    assign(informe,'kdlfjaskl');
    rewrite(informe);
    reset(archm);
    minimo(archD,vreg,min);
    read(archm,regm);
    while(min.codigo <> alto) do begin
        actual.codigo := min.codigo;
        actual.cantidad:= 0;
        while(actual.codigo = min.codigo) do begin
            actual.cantidad:= actual.cnatidad + min.cantidad;
            minimo(archD,vreg,min);
        end;
        while(regm.codigo <> actual.codigo) do
            read(archm,regm);
        regm.stockA:= regm.stockA - actual.cantidad;
        seek(archm,filePos(archm)-1);
        write(archm,regm); //actualizo el maestro
        if(actual.cantidad * regm.precio > 10000) then begin
            writeln(informe,'producto: ',regm.nombre,' ',regm.codigo,' precio: ',regm.precio,' stock  actual: ', regm.stockA,' stock minimo: 'regm.stockMin);
        end;
    end;
    for i:= 1 to 20 do
        close(archD[i]);
    close(archm);
    close(informe);
end;

var
archM: master;
archD: vDetalle;
i: integer;
nombre: string;
begin
    assign(archM,'klfdajskl');
    for i := 1 to 20 do begin
        read(nombre);
        assign(archD[i],nombre);
    end;
    actualizar(archD,archM);
end.