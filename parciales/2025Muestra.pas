{Una plataforma digital organiza cada año una serie de eventos de sesiones musicales en vivo.
Cada evento cuenta con múltiples presentaciones realizadas en distintas fechas, y un mismo
artista puede participar varias veces en el mismo evento un mismo año.
Se dispone de un archivo que contiene la información de cada presentación individual. Cada
registro indica: el código del artista, el nombre del artista, el año en el que se realizó la
presentación, el código del evento, el nombre del evento, la cantidad de "likes" recibidos durante
esa presentación, la cantidad de "dislikes" recibidos, y el puntaje otorgado por el jurado técnico a
dicha presentación. El archivo está ordenado por año, luego por código de evento, y finalmente
por código de artista.  
Nota: El artista menos influyente del evento, es aquel con menor puntaje total del jurado
acumulado. En caso de empate, se debe elegir al que haya recibido más dislikes,
independientemente de la diferencia. En caso de que haya empate nuevamente, elegir
cualquiera de los que tiene el menor puntaje total del jurado y la mayor cantidad de dislikes.}

program 2025Muestra;
const
alto = 99999;
type
presentacion = record
    codigoArtista: integer;
    nombre: string;
    anio: integer;
    codigoEvento: integer;
    evento: string;
    likes: integer;
    dislikes: integer;
    puntaje: real;
end;

TArchivo = file of presentacion;

procedure leer(var arch: TArchivo; var reg: presentacion);
begin
    if(not EOF(arch)) then
        read(arch,reg)
    else
        reg.anio = alto;
end;

//anio, evento, artista
procedure informar(var a: TArchivo);
var
reg,act: presentacion;
puntajeMin: real;
cantPresentaciones,totalPresentaciones,cantAnios,dislikesMax: integer;
menorArtista: string;
begin
    reset(a);
    leer(a,reg);
    cantAnios := 0;
    
    totalPresentaciones := 0;
    writeln('Resumen de menor influencia por evento.');
    while(reg.anio <> alto) do begin    
        act.anio = reg.anio;
        writeln('anio: ', reg.anio);
        cantAnios:= cantAnios + 1;
        cantPresentaciones := 0;
        while(act.anio = reg.anio) do begin //  anios
            act.evento := reg.evento;
            writeln(act.evento,' :', act.codigoEvento);
            dislikesMax := -1;
            puntajeMin := alto;
            while(act.anio = reg.anio) and (act.evento = reg.evento) do begin //   eventos
                act.codigoArtista = reg.codigoArtista;
                act.nombre := reg.nombre;
                writeln(act.codigoArtista,' :',reg.nombre);
                act.likes := 0;
                act.dislikes := 0;
                act.puntaje:= 0;
                                                                //artistas
                while(act.anio = reg.anio) and (act.evento = reg.evento) and (act.codigoArtista = reg.codigoArtista) do begin 
                    act.likes := act.likes + reg.likes;
                    act.dislikes := act.dislikes + reg.dislikes;
                    act.puntaje := act.puntaje + reg.puntaje;
                    cantPresentaciones:= cantPresentaciones + 1;
                    leer(a,reg);
                end;
                writeln(act.likes);
                writeln(act.dislikes);
                writeln(act.likes - act.dislikes);
                writeln(act.puntaje);

                if(puntajeMin > act.puntaje) or ((puntajeMin = act.puntaje) and (dislikesMax < act.dislikes))  then begin
                    puntajeMin := act.puntaje;
                    dislikesMax := act.dislikes;
                    menorArtista := act.nombre;
                end;
        
            end;
            writeln('el artista ', menorArtista, ' fue el menos influyente del evento: ', act.evento, 'del anio: ',act.anio);
        end;
        writeln('durante el anio: ', act.anio,' se registraron ',cantPresentaciones,' de presentaciones');
        totalPresentaciones:= totalPresentaciones + cantPresentaciones;
    end;
    writeln('el promedio total de cantidad de presentaciones por anio es de: ', totalPresentaciones/cantAnios);
    close(a);
end;
var
a: TArchivo;
begin
    informar(a);
end.    