{7. Se dispone de un archivo maestro con información de los alumnos de la Facultad de Informática. Cada
registro del archivo maestro contiene: código de alumno, apellido, nombre, cantidad de cursadas
aprobadas y cantidad de materias con final aprobado. El archivo maestro está ordenado por código de
alumno.

Además, se dispone de dos archivos detalle con información sobre el desempeño académico de los
alumnos: un archivo de cursadas y un archivo de exámenes finales.

El archivo de cursadas contiene información sobre las materias cursadas por los alumnos. Cada registro
incluye: código de alumno, código de materia, año de cursada y resultado (solo interesa determinar si la
cursada fue aprobada o desaprobada).

Por su parte, el archivo de exámenes finales contiene información sobre los exámenes rendidos. Cada
registro incluye: código de alumno, código de materia, fecha del examen y nota obtenida.

Ambos archivos detalle están ordenados por código de alumno y código de materia, y pueden contener
cero, uno o más registros por alumno.
Un alumno puede cursar una misma materia varias veces, así como también rendir el examen final en
múltiples ocasiones.
Se solicita desarrollar un programa que actualice el archivo maestro, modificando la cantidad de cursadas
aprobadas y la cantidad de materias con final aprobado, a partir de la información contenida en los archivos
detalle.
Las reglas de actualización son las siguientes:
● Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas aprobadas.
● Si un alumno aprueba un examen final (nota mayor o igual a 4), se incrementa en uno la cantidad de
materias con final aprobado.
Notas:
● Los archivos deben procesarse en un único recorrido.
● No es necesario verificar inconsistencias en la información de los archivos detalle. En particular, se
garantiza que un alumno no puede aprobar más de una vez la cursada de una misma materia. De
manera análoga, tampoco puede aprobar más de una vez el examen final de una misma materia.}

program Ejercicio7;
const
alto = 99999;
type
Master = record
    alumno: integer;
    apellido: string;
    nombre: string;
    cursadas: integer;
    finales: integer;
end;
cursada = record
    alumno: integer;
    materia: integer;
    anio: integer;
    resultado: Boolean;
end;
finales = record
    alumno: integer;
    materia: integer;
    fecha: string;
    nota: integer;
end;
tcursadas = file of cursada;
tfinales = file of finales;
tmaster = file of Master;

procedure leerFinal(var archf: tfinales; var reg: finales);
begin
    if(not eof(archf))then
        read(archf,reg)
    else
        reg.alumno:= alto;
end;    

procedure leerCursada(var archc: tcursadas; var reg: cursada);
begin
    if(not eof(archc))then
        read(archc,reg)
    else 
        reg.alumno:= alto;
end;    
procedure actualizar(var archf: tfinales;var archc: tcursadas; var archm: tmaster);
var
regf: finales;
regc: cursada;
regm: Master;
totalF,totalC,actual,Mactual: integer;
begin
    leerFinal(archf,regf);
    leerCursada(archc,regc);
    read(archm,regm);
    while(regf.alumno <> alto) or (regc.alumno <> alto) do begin
        totalF:= 0;
        totalC:= 0;
        {busco el alumno menor entre todos}
        if(regf.alumno < regc.alumno) then
            actual:= regf.alumno
        else 
            actual:= regc.alumno;
        {evaluo los finales del alumno actual}
        while(regf.alumno = actual) do begin
            mactual:= regf.materia;
            while (regf.alumno = actual) and (regf.materia = mactual) do begin
                if(regf.nota >= 4) then
                    totalF:= totalF + 1;
                leerFinal(archf,regf);
            end;    
        end;    
        {evaluo las cursadas del alumno actual}
        while(regc.alumno = actual) do begin
            mactual:= regc.materia;
            while(regc.alumno = actual) and (regc.materia = mactual) do begin
                if(regc.resultado) then
                    totalC:= totalC + 1;
                leerCursada(archc,regc);
            end;    
        end; 
        {aca ya recopile toda la info para actualizar el master}
        while(regm.alumno <> actual) do
            read(archm,regm);
        seek(archm,filepos(archm)-1);
        regm.cursadas:= regm.cursadas + totalC;
        regm.finales:= regm.finales + totalF;
        write(archm,regm);   
    end;    
end;    

var 
archf: tfinales;
archc: tcursadas;
archm: tmaster;
begin
    Assign(archm,'master.dat');
    Assign(archf,'finales.dat');
    Assign(archc,'cursadas.dat');

    reset(archf);
    reset(archc);
    reset(archm);
    actualizar(archf,archc,archm);

    close(archf);
    close(archc);
    close(archm);
end.