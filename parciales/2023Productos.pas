program jdfaj;
const

type
producto = record
    codigo: integer;
    nombre: string;
    descripcion: string;
    precioCompra: real;
    precioVenta: real;
    ubicacion: string;
end;

tmaster = file of producto;

procedure alta(var archM: tmaster);
var
p,cabecera: producto;
pos: integer;
begin
    reset(archm);
    writeln('ingrese el codigo del producto');
    readln(p.codigo);
    if(existeProducto(p.codigo,archM)) then
        writeln('el producto ya existe')
    else begin
        seek(archm,0);
        writeln('ingrese el resto de los datos');
        readln(p.nombre);
        read(archm,cabecera);
        if(cabecera.codigo = 0) then begin
            seek(archm,filesize(archm));
            write(archm,p);
            writeln('se agrego el producto al final del archivo');
        end
        else begin
            pos:= cabecera.codigo * -1;

            seek(archM,pos);
            read(archm,cabecera);
            seek(archm,filePos(archm) - 1);
            write(archm,p);
            seek(archm,0);
            write(archm,cabecera);
        end;
    end;
    close(archM);
end;

procedure Eliminar(var archM: tmaster);
var
codigoEliminar,pos: integer;
cabecera,reg: producto;
begin
    writeln('ingrese el codigo a eliminar');
    readln(codigoEliminar);
    reset(archm);
    if(not existeProducto(codigoEliminar,archM)) then
        writeln('el producto que se quiere eliminar no existe')
    else begin
        seek(archm,0);
        read(archm,cabecera);
        read(archm,reg);
        while(reg.codigo <> codigoEliminar) do begin
            read(archm,reg);
        end;
        seek(archm,filePos(archm)-1);
        pos:= filePos(archm);
        write(archm,cabecera);

        cabecera.codigo := pos * -1;
        seek(archm,0);
        write(archm,cabecera);
    end;
    close(archM);
end;

var
archM: tmaster;
begin
    assign(archM,'fjasdkl');
    alta(archM);
end.