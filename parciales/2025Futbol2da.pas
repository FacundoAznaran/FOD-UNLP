program fjasdkf;

const
alto = 99999;
type
equipo = record
    codigo: integer;
    nombre: string;
    cantJugados: integer;
    cantGanados: integer;
    cantEmpatados: integer;
    cantPerdidos: integer;
    cantPuntos: integer;
end;
detalle = record
    codigo: integer;
    fecha: string:
    cantPuntos: integer;
    codigoRival: integer;
end;
Tmaster = file of equipo;
TDetalle = file of detalle;

vectorDetalle = array[1..12] of tdetalle;
vectorRegistros = array[1..12] of detalle;

procedure leer(var archd: tdetalle; var reg: detalle);
begin
    if(not EOF(archd)) then
        read(archD,reg)
    else
        reg.codigo := alto;
end;

procedure minimo(var archd: vectorDetalle; var vReg: vectorRegistros; var min: detalle);
var
i,pos: integer;
begin
    pos:= -1;
    min.codigo:= alto;
    for i:= 1 to 12 do begin
        if(min.codigo > vreg[i].codigo) then begin
            pos:= i;
            min.codigo:= vreg[i].codigo;
        end;
    end;

    if(pos <> -1) then begin
        min:= vreg[pos];
        leer(archd[pos],vreg[pos]);
    end;
end;

procedure actualizar(var archd: vectorDetalle; var archm: tmaster);
var
vReg: vectorRegistros;
regM: equipo;
min: detalle;
nombreMax: string;
i,Pmax,puntos: integer;
begin
    for i:= 1 to 12 do 
        leer(archd[i],vreg[i]);
    minimo(archd,vreg,min);
    pMax:= -1;

    while(min.codigo <> alto) do begin
        read(archm,regM);
        puntos:= 0;
        while(regM.codigo <> min.codigo) do // busco en el maestro
            read(archm,regm);
        while(regM.codigo = min.codigo) do begin
            puntos:= puntos + min.cantPuntos;
            if(min.cantPuntos = 3) then
                regM.cantGanados:= regM.cantGanados + 1
            else
            if(min.cantPuntos = 1) then
                regM.cantEmpatados:= regM.cantEmpatados + 1
            else
                regM.cantPerdidos:= regM.cantPerdidos + 1;
            regM.cantJugados:= regM.cantJugados + 1;
            regM.cantPuntos:= regM.cantPuntos + min.cantPuntos;
            minimo(archd,vreg,min);
        end;
        if(puntos > Pmax) then begin
            Pmax:= puntos;
            nombreMax:= regM.nombre;
        end;
        seek(archm,filePos(archm)-1);
        write(archm,regM);
    end;
    writeln('el equipo que sumo mas puntos fue: ',nombreMax,' con un total de: ',Pmax);

end;

var
archd: vectorDetalle;
archM: tmaster;
i: integer;
nombre: string;
begin
    assign(archm,'fkladjskl');
    for i:= 1 to 12 do begin
        readln(nombre);
        assign(archd[i],nombre);
        reset(archd[i]);
    end;
    reset(archm);
    actualizar(archD,archm);
    close(archm);
    for i:= 1 to 12 do
        close(archd[i]);
end.