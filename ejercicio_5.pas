{
   5. Realizar un programa para una tienda de celulares, que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados
desde un archivo de texto denominado “celulares.txt”. Los registros correspondientes a
los celulares deben contener: código de celular, nombre, descripción, marca, precio,
stock mínimo y stock disponible. El formato del archivo de texto de carga se especifica en
la NOTA 2 ubicada al final del ejercicio.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock
mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de
caracteres proporcionada por el usuario.
d. Exportar el archivo binario creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado podría ser
utilizado en un futuro como archivo de carga (ver inciso a), por lo que debería respetar el
formato dado para este tipo de archivos en la NOTA 2.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en tres
líneas consecutivas. En la primera se especifica: código de celular, el precio y marca, en la
segunda el stock disponible, stock mínimo y la descripción y en la tercera nombre en ese orden.
Cada celular se carga leyendo tres líneas del archivo “celulares.txt”.

Ejemplo de Archivo
101 250000 Samsung
15 5 Galaxy A15 128GB
Galaxy A15
102 320000 Motorola
3 6 Moto G84 256GB color azul
Moto G84
104 950000 Apple
2 4 iPhone 15 256GB negro
iPhone 15
   
   
}


program untitled;
type
celular = record
	marca: string;
	desc: string;
	min: integer;
	disponible: integer;
	nombre: string;
	precio: real;
	cod: integer;
	end;
archivo = file of celular;



procedure crearArchivo(var arch: archivo; var txt: text);
var
c: celular;
begin
	assign(arch,'celularesLista');
	rewrite(arch);
	while not eof(txt)do begin
		readln(txt,c.cod,c.precio,c.marca);
		readln(txt,c.disponible,c.min,c.desc);
		readln(txt,c.nombre);
		write(arch,c);
	end;
	writeln('archivo cargado');
end;

procedure mostrar(c: celular);
begin
	writeln(c.marca);
	writeln(c.desc);
	writeln(c.min);
	writeln(c.disponible);
	writeln(c.precio);
	writeln(c.nombre);
	writeln(c.cod);
	writeln('---------------------------');
end;
procedure listarMin(var arch: archivo);
var
c:celular;
begin
	writeln('lista de los menores');
	while not eof(arch) do begin
		read(arch,c);
		if(c.min > c.disponible) then
			mostrar(c);
	end;
end;

procedure buscarDesc(var arch: archivo);
var
c: celular;
d: string;
begin
	seek(arch,0);
	writeln('ingrese la descripcion');
	readln(d);
	while not eof(arch)do begin
		read(arch,c);
		if(c.desc = d) then
			mostrar(c);
	end;
end;

var 
arch: archivo;
txt: text;

BEGIN
	assign(txt,'celulares.txt');
	reset(txt);
	crearArchivo(arch,txt);
	close(arch);
	reset(arch);
	listarMin(arch);
	buscarDesc(arch);
END.

