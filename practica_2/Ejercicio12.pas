{12. La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web de la
organización. En dicho servidor, se almacenan en un archivo todos los accesos que se realizan al sitio.
La información que se almacena en el archivo es la siguiente: año, mes, día, idUsuario y tiempo de
acceso al sitio de la organización. El archivo se encuentra ordenado por los siguientes criterios: año,
mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará el año
calendario sobre el cual debe realizar el informe.

Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no
encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información necesaria.}
program Ejercicio12;
const
alto = 9999;
type
master = record
    anio: integer;
    mes: Integer;
    dia: Integer;
    id: integer;
    tiempo: integer;
end;
tmaster = File of master;

procedure leer(var archm: tmaster; var reg: master);
begin
    if(not eof(archm)) then
        read(archm,reg)
    else 
        reg.anio:= alto;
end;    

var 
archm: tmaster;
regm: master;
anio,mes,dia,id,tiempoD,tiempoM,tiempoA,tiempoU: Integer;
begin
    WriteLn('ingrese el anio');
    assign(archm,'master.dat');
    reset(archm);
    ReadLn(anio);
    leer(archm,regm);
    tiempoA:= 0;
    while(regm.anio <> anio) and (regm.anio <> alto) do begin
        leer(archm,regm);
    end;    
    if(regm.anio <> alto) then begin
        WriteLn('anio: ',anio);
        while(regm.anio = anio)do begin
            tiempoM:= 0;
            mes:= regm.mes;
            WriteLn('mes: ', mes);
            while(regm.anio = anio) and (regm.mes = mes) do begin
                tiempoD:= 0;
                dia:= regm.dia;
                WriteLn('dia: ',dia);
                while(regm.anio = anio) and (regm.mes = mes) and (regm.dia = dia) do begin
                    tiempoU:= 0;
                    id:= regm.id;
                    WriteLn('usuario: ',id);
                    while(regm.anio = anio) and (regm.mes = mes) and (regm.dia = dia) and (regm.id = id) do begin
                        tiempoU:= tiempoU + regm.tiempo;
                        leer(archm,regm);
                    end;    
                    tiempoD:= tiempoD + tiempoU;
                    WriteLn('usuario: ',id,' tiempo en el mes ', mes,' dia ',dia,': ',tiempoU );
                end;    
                tiempoM:= tiempoM + tiempoD;
                WriteLn('tiempo total del dia: ',dia,' en el mes: ', mes,': ',tiempoD);
            end;   
            tiempoA:= tiempoA + tiempoM;
            writeln('tiempo en el mes ', mes,': ',tiempoM);
        end;    
        writeln('tiempo total del anio ',anio,': ',tiempoA);
    end
    else
        WriteLn('no se encontro el anio');
end. 