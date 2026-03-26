{
   ejercicio_3.pas
   
   3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo binario de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de empleado,
apellido, nombre, edad y DNI. Algunos empleados pueden ingresan el DNI con valor 0, lo
que significa que al momento de la carga puede no tenerlo. La carga finaliza cuando se
ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado, el cual se proporciona desde el teclado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.
   
   4. Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado.
Tener en cuenta que no se debe agregar al archivo un empleado con un número de
empleado ya registrado (control de unicidad).
b. Modificar la edad de un empleado dado.
c. Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.
d. Exportar a un archivo de texto llamado “faltaDNIEmpleado.txt”, los empleados que no
tengan cargado el DNI (DNI en 0).
NOTA: Las búsquedas deben realizarse por número de empleado.
}


program untitled;
type

empleado = record
	apellido: string;
	edad: integer;
	numero: integer;
	dni: integer;
	end;

archivo = file of empleado;

procedure leerEmpleado(var e: empleado);
begin
	writeln('ingrese el apellido (fin para terminar)');
	readln(e.apellido);
	if(e.apellido <> 'fin') then begin
		writeln('ingrese la edad');
		readln(e.edad);
		writeln('ingrese el numero');
		readln(e.numero);
		writeln('ingrese el dni');
		readln(e.dni);
	end;
	writeln('-----------------------');
end;

procedure crearArchivo(var arch: archivo;nombre: string);
var
e: empleado;
begin
	rewrite(arch);
	leerEmpleado(e);
	while(e.apellido <> 'fin') do begin
		write(arch,e);
		leerEmpleado(e);
	end;
	close(arch);
end;

procedure mostrar(e: empleado);
begin
	writeln('edad: ', e.edad);
	writeln('apellido: ', e.apellido);
	writeln('numero: ', e.numero);
	writeln('dni: ', e.dni);
	writeln('---------------------------------------');
end;

procedure mostrarApellido(var arch: archivo);
var
apellido: string;
e: empleado;
begin
	reset(arch);
	writeln('ingrese el apellido a buscar');
	readln(apellido);
	while not eof(arch) do begin
		read(arch,e);
		if(e.apellido = apellido) then
			mostrar(e);
	end;
	close(arch);
end;

procedure mostrarTodo(var arch: archivo);
var
e: empleado;
begin
	reset(arch);
	writeln('Listado de todos');
	while not eof(arch) do begin
		read(arch,e);
		mostrar(e);
	end;
	close(arch);
end;

procedure mostrarViejos(var arch: archivo);
var
e: empleado;
begin
	reset(arch);
	writeln('Listado de viejos');
	while not eof(arch) do begin
		read(arch,e);
		if(e.edad >= 70) then
			mostrar(e);
	end;
	close(arch);
end;

procedure agregar(var arch: archivo);
var
e,x: empleado;
n: integer;
esta: boolean;
begin
	reset(arch);
	writeln('ingrese -1 para terminar');
	readln(n);
	while(n <> -1) do begin
		leerEmpleado(e);
		esta:= false;
		while not eof(arch) and (not esta) do begin
			read(arch,x);
			if(x.numero = e.numero) then begin
				esta:= True;
				writeln('el empleado ya existe...');
			end;
		end;
		if(not esta) then begin
			write(arch, e);
			writeln('se agrego el empleado correctamente');
		end;
		seek(arch,0);
		writeln('ingrese -1 para terminar');
		readln(n);
	end;
	close(arch);
end;

procedure modificar(var arch: archivo);
var
id: integer;
encontre: boolean;
e: empleado;
begin
	reset(arch);
	writeln('ingrese el numero de empleado a modificar');
	readln(id);
	encontre:= false;
	while not eof(arch) and (not encontre) do begin
		read(arch, e);
		if(e.numero = id) then begin
			writeln('se encontro, ingrese la edad a cambiar');
			readln(e.edad);
			seek(arch, filepos(arch)-1);
			write(arch,e);
			encontre:= true;
		end;
	end;
	if(not encontre) then
		writeln('no existe el empleado: ', id);
	close(arch);
end;
procedure exportar(var arch: archivo);
var
texto: text;
e: empleado;
begin
	assign(texto,'texto_de_todos_los_empleados');
	rewrite(texto);
	reset(arch);
	while not eof(arch) do begin
		read(arch,e);
		writeln(texto, ' ', e.numero, ' ', e.apellido, ' ', e.dni, ' ',e.edad);
	end;
	
	close(texto);
	close(arch);
end;

procedure exportardni(var arch: archivo);
var
texto: text;
e: empleado;
begin
	assign(texto,'texto_sinDNI');
	rewrite(texto);	
	reset(arch);
	while not eof(arch) do begin
		read(arch,e);
		if(e.dni = 0) then
			writeln(texto, ' ', e.numero, ' ', e.apellido, ' ', e.dni, ' ',e.edad);
	end;
	
	close(texto);
	close(arch);
end;

var 
arch: archivo;
nombre: string;
opcion: integer;
BEGIN
	writeln('ingrese el nombre del archivo');
	readln(nombre);
	assign(arch, nombre);
	crearArchivo(arch,nombre);
	
	writeln('0(terminar) ,ingrese 1: apellido, 2 todo, 3 viejos, 4 agregar, 5 modificiar, 6 txt, 7 txt sin DNI');
		readln(opcion);
		
	while(opcion <> 0) do begin
		
		if(opcion = 1) then
			mostrarApellido(arch)
		else
		if(opcion = 2) then
			mostrarTodo(arch)
		else
		if(opcion = 3) then
			mostrarViejos(arch)
		else
		if(opcion = 4) then
			agregar(arch)
		else
		if(opcion = 5) then
			modificar(arch)
		else
		if(opcion = 6) then
			exportar(arch)
		else
		if(opcion = 7) then
			exportardni(arch);
		writeln('0(terminar) ,ingrese 1: apellido, 2 todo, 3 viejos, 4 agregar, 5 modificiar, 6 txt, 7 txt sin DNI');
		readln(opcion);
	end;
	
END.

