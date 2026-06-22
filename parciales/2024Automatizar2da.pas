program dfaklsd;
const
alto = 9999;

type
master = record
    codigo: integer;
    nombre: string;
    cantidad: integer;
end;

detalle = record
    codigo: integer;
    cantidad: integer;
end;

archM = file of master;


archD = file of detalle;

Vdetalle = array[1..30] of archD;
vReg = array[1..30] of detalle;

procedure leerDetalle(var archD: archD; var reg: detalle);
begin
    if(not EOF(archD)) then
        read(archD,reg)
    else
        reg.codigo := alto;
end;

procedure leerMaster(var archM: archM; var reg: master);
begin
    if(not EOF(archM)) then
        read(archM,reg)
    else
        reg.codigo:= alto;
end;

procedure minimo(var archD: Vdetalle;var VReg: vreg; var min: detalle);
var
i,pos: integer;
begin
    pos := -1;
    min.codigo := alto;
    for i := 1 to 30 do begin
        if(vreg[i].codigo < min.codigo) then begin
            pos := i;
            min.codigo := vreg[i].codigo;
        end;
    end;
    if(pos <> -1) then begin
        min := Vreg[pos];
        leerDetalle(archD[pos],VReg[pos]);
    end;
end;

procedure actualizar(var archD: Vdetalle; var archM: archM);
var
Vreg: vReg;
min: detalle;
regM: master;
i,actual,cantidad: integer;
begin
    for i := 1 to 30 do begin
        leerDetalle(archD[i],Vreg[i]);
    end;
    minimo(archD,vreg,min);
    leerMaster(archM,regM);
    while(regM.codigo <> alto) do begin
        if(regM.codigo = min.codigo) then begin
            cantidad := 0;
            actual:= min.codigo;
            while(actual = min.codigo) do begin
                cantidad:= cantidad + min.cantidad;
                minimo(archD,vreg,min);
            end;
            RegM.cantidad := cantidad;
            seek(archM,filePos(archM)-1);
            write(archM,regm);
        end;
        if(regM.cantidad > 15) then begin
            writeln(regM.codigo,' ',regm.nombre,' :',regm.cantidad);
        end;
        leerMaster(archM,regM);
    end;
end;

var
archD: Vdetalle;
archM: archM;
i: integer;
nombre: string;
begin
    for i := 1 to 30 do begin
        readln(nombre);
        assign(archD[i],nombre);
        reset(archD[i]);
    end;
    assign(archM,'fadsfasdfdas');
    reset(archM);
    actualizar(archD,archM);
    for i := 1 to 30 do 
        close(archD[i]);
    close(archM);
end.