{3. A partir de información sobre la alfabetización en la Argentina, se desea actualizar un archivo maestro
que contiene los siguientes datos: nombre de la provincia, cantidad de personas alfabetizadas y total de
encuestados.
Para ello, se dispone de dos archivos detalle, provenientes de distintas agencias de censo. Cada uno de
estos archivos contiene: nombre de la provincia, código de localidad, cantidad de personas alfabetizadas
y cantidad de encuestados.
Se solicita desarrollar los módulos necesarios para actualizar el archivo maestro a partir de la
información contenida en ambos archivos detalle.
Nota: Todos los archivos están ordenados por nombre de provincia. En los archivos detalle pueden
existir cero, uno o más registros por cada provincia.}
program Ejercicio3;
const
alto = 'ZZZZZZZ';
type

tipoMaestro = record
    provincia: string;
    alfabetizados: integer;
    total: integer;
end;

tipoDetalle = record
    provincia: string;
    codigo: integer;
    alfabetizados: integer;
    encuestados : integer;
end;

maestro = file of tipoMaestro;
detalle = file of tipoDetalle;


procedure leer(var arch: detalle;var reg: tipoDetalle);
begin
    if EOF(arch) then
        reg.provincia := alto
    else
        read(arch,reg);
end;

procedure minimo(var det1,det2: detalle; var reg1,reg2,min: tipoDetalle);
begin
    if(reg1.provincia <= reg2.provincia) then begin
        min := reg1;
        leer(det1,reg1);
    end
    else begin
        min := reg2;
        leer(det2,reg2);
    end;
end;

procedure actualizar(var maestro: maestro; var det1,det2: detalle;var regm: tipoMaestro;var regd1,regd2: tipoDetalle);
var 
min: tipoDetalle;
totalA,totalE: integer;
actual: string;
begin
    read(maestro,regm);
    leer(det1,regd1);
    leer(det2,regd2);
    minimo(det1,det2,regd1,regd2,min);
    while(min.provincia <> alto) do begin
        totalA := 0;
        totalE := 0;
        actual := min.provincia;
        while(min.provincia = actual) do begin
            totalA := totalA + min.alfabetizados;
            totalE := totalE + min.encuestados;
            minimo(det1,det2,regd1,regd2,min);
        end;
        while(regm.provincia <> actual) do begin
            read(maestro,regm);
        end;
        regm.alfabetizados := regm.alfabetizados + totalA;
        regm.total := regm.total + totalE;
        seek(maestro,filepos(maestro)-1);
        write(maestro,regm);
    end;
end;


var
archM: maestro;
det1,det2: detalle;
regm: tipoMaestro;
regd1,regd2: tipoDetalle;

begin
    Assign(archM, 'maestro.dat');
    assign(det1, 'detalle1.dat');
    assign(det2, 'detalle2.dat');
    reset(archM);
    reset(det1);
    reset(det2);
    actualizar(archM,det1,det2,regm,regd1,regd2);
    close(archM);
    close(det1);
    close(det2);
end.