program jfasdklj;

const
alto = 99999;
type
prestamo = record
    codigo: integer;
    dni: integer;
    Nprestamo: integer;
    fecha: integer;
    monto: real;
end;
master = file of prestamo;
procedure leer(var archM:master; var reg: prestamo);
begin
    if(not EOF(archm)) then
        read(archm,reg)
    else
        reg.codigo := alto;
end;
//codigo ---> dni ---> fecha

procedure crearInforme(var archM:master);
var
texto: text;
actual,regM: prestamo;
totalVS,totalV,cant,totalVE: integer;
totalMS,TotalM,totalME:real;
begin
    rewrite(texto,'fklads');
    leer(archm,regM);
    totalV:= 0;
    totalM:= 0;
    while(regM.codigo <> alto) do begin
        actual.codigo:= regm.codigo;
        totalVS:= 0;
        totalMS:= 0;
        writeln('sucursal: ',actual.codigo);
        while(actual.codigo = regm.codigo) do begin
            actual.dni:= regm.dni;
            totalVE:= 0; totalME:= 0;
            writeln('empleado DNI: ',actual.dni);
            while(actual.dni = regm.dni) and (actual.codigo = regm.codigo) do begin
                actual.fecha:= regm.fecha;
                writeln('anio ',regm.fecha);
                actual.monto:= 0;
                cant:= 0;
                while(actual.fecha = regm.fecha) and (actual.dni = regm.dni) and (actual.codigo = regm.codigo) do begin
                    actual.monto:= actual.monto + regm.monto;
                    cant:= cant + 1;
                    leer(archm,regm);
                end;
                writeln('cantidad de ventas: ',cant,' monto: ',actual.monto);
                totalME:= totalME + actual.monto;
                totalVE:= totalVE + cant;
            end;
            writeln('total de ventas empleado: ',totalVE,' total monto empleado: ',totalME);
            totalVS:= totalVS + totalVE;
            totalMS:= totalMS + totalME;
        end;
        writeln('total de ventas sucursal: ', totalVS,' total monto sucursal: ',totalMS);
        totalM:= totalM + totalMS;
        totalV:= totalV + totalVS;
    end;
    writeln('cantidad de ventas total empresa: ',totalV,' cantidad total monto empresa: ',totalM);
    close(texto);
end;

var
archm: master;
begin
    assign(archm,'klfdjaskl');
    reset(archm);
    crearInforme(archM);
    close(archm);
end.