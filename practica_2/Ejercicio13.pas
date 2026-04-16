{13. Suponga que usted es administrador de un servidor de correo electrónico. En los logs del mismo
(información guardada acerca de los movimientos que ocurren en el server) que se encuentra en la
siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: nro_usuario, nombreUsuario,
nombre, apellido, cantidadMailEnviados. Diariamente el servidor de correo genera un archivo con la
siguiente información: nro_usuario, cuentaDestino, cuerpoMensaje. Este archivo representa todos los
correos enviados por los usuarios en un día determinado. Ambos archivos están ordenados por
nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.

a. Realice el procedimiento necesario para actualizar la información del log en un día particular.
Defina las estructuras de datos que utilice su procedimiento.

b. Genere un archivo de texto que contenga el siguiente informe dado un archivo detalle de un
día determinado:

nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados

Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que existen en
el sistema. Considere la implementación de esta opción de las siguientes maneras:

i- Como un procedimiento separado del punto a).

ii- En el mismo procedimiento de actualización del punto a). Qué cambios se
requieren en el procedimiento del punto a) para realizar el informe en el mismo
recorrido?}
program Ejercicio13;
const 
alto = 99999;
type
master = record
    numero: integer;
    nombreUsuario: string;
    nombre: string;
    apellido: string;
    cantidad: integer;
end;
log = record
    numero: integer;
    destino: integer;
    cuerpo: string;
end;

tmaster = file of master;
tdetalle = file of log;

procedure leer(var archd: tdetalle; var reg: log);
begin
    if(not eof(archd)) then
        read(archd,reg)
    else 
        reg.numero:= alto;
end;    

procedure actualizar(var archm: tmaster; var archd: tdetalle);
var
texto: text;
regm: master;
regd: log;
total,actual: Integer;
begin
    Assign(texto,'informe.txt');
    Rewrite(texto);
    leer(archd,regd);
    read(archm,regm);
    while(regd.numero <> alto) do begin
        total:= 0;
        actual:= regd.numero;
        while(actual = regd.numero) do begin
            total:= total + 1;
            leer(archd,regd);
        end;  
        {proceso el master para hacer el informe del texto}
        while(regm.numero <> actual) do begin
            if(regm.numero <> actual) then
                WriteLn(texto,'usuario: ',regm.numero,' cantidad de mensaje: ',0);
            read(archm,regm);
        end;    
        regm.cantidad:= regm.cantidad + total;
        WriteLn(texto,'usuario: ',actual,' cantidad de mensaje: ',total);
        seek(archm,FilePos(archm)-1);
        write(archm,regm);
    end;
    {termino de procesar lo que me quedo del master}    
    if(eof(archm)) then
        regm.numero:= alto;
    while(regm.numero <> alto) do begin
        WriteLn(texto,'usuario: ',regm.numero,' cantidad de mensaje: ',0);
        if(not eof(archm)) then
            read(archm,regm)
        else 
            regm.numero:= alto;
    end;    
    close(texto);
end;    
{ejemplo de como seria con el punto i}
procedure generarInformeSeparado(var archm: tmaster; var archd: tdetalle);
var
    texto: text;
    regm: master;
    regd: log;
    total, actual: integer;
begin
    Assign(texto, 'informe_solo.txt');
    Rewrite(texto);
    
    { Volvemos los punteros al principio por seguridad }
    reset(archm);
    reset(archd);
    
    leer(archd, regd);
    leerMaster(archm, regm); // Usando el procedimiento leer con 'alto'

    { El que manda es el Maestro porque el informe debe contener a TODOS }
    while (regm.numero <> alto) do begin
        actual := regm.numero;
        total := 0;

        { Si el usuario del maestro coincide con el del detalle, sumo sus mails }
        while (regd.numero = actual) do begin
            total := total + 1;
            leer(archd, regd);
        end;

        { Escribo en el informe. Si no hubo coincidencia, total será 0 }
        WriteLn(texto, 'usuario: ', regm.numero, ' cantidad de mensajes enviados hoy: ', total);

        { Avanzo al siguiente del maestro }
        leerMaster(archm, regm);
    end;

    Close(texto);
    writeln('Informe generado con éxito.');
end;

var 
archm: tmaster;
archd: tdetalle;
begin
    assign(archm,'/var/log/maestro.dat');
    Assign(archd,'detalle.dat');
    reset(archm);
    reset(archd);
    actualizar(archm,archd);
    close(archm);
    close(archd);
end. 