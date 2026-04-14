{
   sodhfhsdf.pas
   
   Copyright 2026 Facundo <facundo@facundo-System-Product-Name>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


Program P1_E2;

procedure cargarArchivo(var archivo: file of integer);
  var
    num: integer;
  begin
    rewrite(archivo);
    writeln('Ingrese un numero (30000 para finalizar): ');
    readln(num);
    while num <> 30000 do
    begin
      write(archivo, num);
      writeln('Ingrese otro numero (30000 para finalizar): ');
      readln(num);
    end;
    close(archivo);
  end;

var
  archivo: file of integer;
  nomArchivo: string;
  num: integer;
  cantMin: integer;
  suma: integer;
  total: integer;
  prom: real;


begin
  cantMin:= 0;
  suma:= 0;
  total:= 0;
  write('Ingrese el nombre del archivo: '); readln(nomArchivo);
  assign(archivo, nomArchivo);
  cargarArchivo(archivo);
  reset(archivo);
  writeln('Contenido del archivo: ');
  while not EOF(archivo) do begin
    read(archivo,num);
    writeln(num);
    suma:= suma + num;
    total:= total + 1;
    if (num < 15000) then
       cantMin:= cantMin + 1;
  end;
  close(archivo);
  if(total > 0) then
    prom:= suma/total
  else
    prom:= 0;
  writeln('Cantidad de numeros menores a 15000: ',cantMin);
  writeln('Promedio: ',prom:0:2);
end.
