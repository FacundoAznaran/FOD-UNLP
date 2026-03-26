{
   ejercicio_2.pas
   
   2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados creado en el
ejercicio 1, informe por pantalla cantidad de números menores a 15000 y el promedio de los
números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario
una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla. Resolver
el ejercicio realizando un único recorrido del archivo.
   
   
}


program untitled;
type

archivo = file of integer;

function promedio (cant, suma: integer): real;
begin
	promedio:= suma/cant;
end;

var arch: archivo;
nombre: string;
cant: integer;
suma: integer;
menores: integer;
num: integer;
BEGIN	
	cant:= 0;
	suma:= 0;
	menores := 0;
	writeln('ingrese el nombre del archivo a ejecutar');
	readln(nombre);
	assign(arch,nombre);
	reset(arch);
	writeln('contenido del archivo');
	while not eof(arch) do begin
		read(arch, num);
		writeln(num);
		if(num < 15000) then
			menores := menores + 1;
		cant:= cant + 1;
		suma:= suma + num;
	end;
	close(arch);
	writeln('la cantidad de numero menores a 15000 es de: ', menores);
	writeln('el promedio de los numeros es: ', promedio(cant,suma));
END.

