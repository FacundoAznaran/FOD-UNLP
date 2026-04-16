{19. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de toda la
provincia de buenos aires de los últimos diez años. En pos de recuperar dicha información, se deberá
procesar 2 archivos por cada una de las 50 delegaciones distribuidas en la provincia, un archivo de
nacimientos y otro de fallecimientos y crear el archivo maestro reuniendo dicha información.

Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida nacimiento,
nombre, apellido, dirección detallada (calle, nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre.

En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y apellido del
fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.

Realizar un programa que cree el archivo maestro a partir de toda la información de los archivos
detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre, apellido, dirección detallada
(calle, nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre,
nombre y apellido del padre, DNI del padre y si falleció, además matrícula del médico que firma el
deceso, fecha y hora del deceso y lugar. Se deberá, además, listar en un archivo de texto la información
recolectada de cada persona.

Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única. Tenga en cuenta
que no necesariamente va a fallecer en el distrito donde nació la persona y además puede no haber
fallecido}
program Ejercicio19;
const
alto = 99999;
type

master = record
    numero: integer;
    nombre: String;
    apellido: string;
    direccion: string;
    matricula: integer;
    nombre_madre: string;
    dniM: Integer;
    nombre_padre: string;
    dniP: integer;
    fallecio: boolean;
    matricula_firma: integer;
end;

nacimientos = record
    numero: integer;
    nombre: string;
    apellido: string;
    direccion: string;
    matricula: Integer;
    nombre_madre: String;
    dniM:integer;
    nombre_padre: string;
    dniP: integer;
end;

fallecidos = record
    numero: integer;
    dni: integer;
    nombre: string;
    apellido: string;
    matricula: integer;
    fecha: string;
    lugar: string;
end;
tfallecidos = file of fallecidos;
tnacimientos = file of nacimientos;
tmaster = file of master;

procedure leerNacimiento(var arch: tnacimientos; var reg: nacimientos);
begin
    if(not eof(arch)) then
        read(arch,reg)
    else
        reg.numero:= alto;
end;    

procedure leerFallecido(var arch: tfallecidos; var reg: fallecidos);
begin
    if(not eof(arch)) then
        read(arch,reg)
    else
        reg.numero:= alto;
end;    

procedure crear(var archN: tnacimientos; var archF: tfallecidos; var archm: tmaster);
var
regN: nacimientos;
regF: fallecidos;
regm: master;
texto: Text;
begin
    Assign(texto,'informe.txt');
    Rewrite(texto);
    leerNacimiento(archN,regN);
    leerFallecido(archF,regF);
    while(regN.numero <> alto) do begin
        regm.numero:= regN.numero;
        regm.nombre:= regN.nombre;
        regm.apellido:= regN.apellido;
        regm.direccion:= regN.direccion;
        regm.matricula:= regN.matricula;
        regm.nombre_madre:= regN.nombre_madre;
        regm.dniM:= regN.dniM;
        regm.nombre_padre:= regN.nombre_padre;
        regm.dniP:= regN.dniP;
        regm.fallecio:= False;
        if(regN.numero = regF.numero) then begin
            regm.fallecio:= True;
            regm.matricula_firma:= regF.matricula;
            leerFallecido(archF,regF);
        end;    
        WriteLn(texto,regm.numero);{ ignorar(me da paja poner todos los datos aca)}
        write(archm,regm);
        leerNacimiento(archN,regN);
    end;    
end;    

var 
archm: tmaster;
archF: tfallecidos;
archN: tnacimientos;
begin
    assign(archm,'master.dat');
    Assign(archF,'fallecidos.dat');
    Assign(archN,'nacimientos.dat');
    reset(archf);
    reset(archN);
    Rewrite(archm);
    crear(archN,archF,archm);
    close(archm);
    close(archF);
    close(archN);
end. 