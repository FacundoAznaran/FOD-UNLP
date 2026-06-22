program jkafdsklfj;

const
alto = 99999;
type
mascota = record
    codigo: integer;
    nombre: string;
    especie: string;
    edad: integer;
    duenio: string;
    telefono: integer;
end;
Master = file of mascota;

procedure leer(var archM: master; var reg: mascota);
begin
    if(not EOF(archM)) then
        read(archM,reg)
    else
        reg.codigo:= alto;
end;

function existeMascota(var archM: master; codigo: integer): integer;
var
reg: mascota;
begin
    seek(archm,1);
    leer(archM,reg);
    while(reg.codigo <> alto) and (reg.codigo <> codigo) do begin
        leer(archM,reg);
    end;
    if(reg.codigo <> alto) then
        existeMascota:= filePos(archM) - 1
    else
        existeMascota:= 0;
end;

procedure altaMascota(var archM: master);
var
m,cabecera: mascota;
pos: integer;
begin
    writeln('ingrese los datos de la mascota');
    readln(m.codigo); // simulo el ingreso de los datos
    reset(archm);
    pos:= existeMascota(archm,m.codigo);
    if(pos <> 0) then
        writeln('la mascota ya existe')
    else begin
        seek(archm,0);
        leer(archm,cabecera);
        if(cabecera.codigo = 0) then begin
            seek(archm,filesize(archm));
            write(archm,m);
            writeln('se ingreso la mascota al final del archivo');
        end
        else begin
            pos:= cabecera.codigo * -1;
            seek(archM,pos);
            read(archM,cabecera);
            seek(archM,pos);
            write(archM,m);

            seek(archm,0);
            write(archm,cabecera);
            writeln('se reaprovecho el espacio del archivo');
        end;
    end;
    close(archm);
end;

procedure BajaMascota(var archM: master);
var
codigo,pos: integer;
cabecera: mascota;
begin
    reset(archm);
    writeln('ingrese la mascota a eliminar');
    readln(codigo);
    pos:= existeMascota(archm,codigo);
    if(pos = 0) then
        writeln('la mascota no existe')
    else begin
        seek(archm,0);
        read(archm,cabecera);
        seek(archm,pos);
        write(archm,cabecera);
        cabecera.codigo:= pos * -1;
        seek(archm,0);
        write(archm,cabecera);
    end;
    close(archm);
end;

var
archM: Master;
begin
    assign(archM,'mascotas');

end.